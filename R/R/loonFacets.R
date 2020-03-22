loonFacets <- function(type, by, args, facet = "grid",
                       by_args, linkingGroup, sync, parent,
                       factory_tclcmd, factory_path,
                       factory_window_title,
                       xlabel = "", ylabel = "", title = "", ...) {
    class(type) <- type[1]
    UseMethod("loonFacets", type)
}

loonFacets.default <- function(type,
                               by,
                               args,
                               facet = "grid",
                               by_args, linkingGroup, sync, parent,
                               factory_tclcmd, factory_path,
                               factory_window_title,
                               xlabel = "", ylabel = "", title = "", ...) {

    by_names <- colnames(by)

    args$by <- by
    args <- l_na_omit(type[1], args, n_dim_states = c(l_nDimStateNames(type[1]), "by"))
    # remove 'by' from args
    by <- setNames(as.data.frame(args$by, stringsAsFactors = FALSE), by_names)
    args$by <- NULL

    ## get N dimensional data frame
    # what is the n?
    x <- args[["x"]]
    N <- if(is.null(x)) {
        # serialaxes?
        x <- args[["data"]]
        if(is.null(x)) integer(0) else dim(x)[1]
    } else {
        length(x)
    }
    # N dim args
    data <- cbind(as.data.frame(args[which(lengths(args) == N)], stringsAsFactors = FALSE), by)
    # 1 dim args
    oneDimArgs <- args[which(lengths(args) != N)]

    subtitles <- setNames(lapply(by, function(b) as.character(levels(factor(b)))), by_names)

    # split data by "by"
    splitted_data <- split(data, f = as.list(by), drop = FALSE, sep = "*")

    if(length(splitted_data) == 1) {

        plot <- do.call(
            loonPlotFactory,
            c(
                args,
                list(factory_tclcmd = factory_tclcmd,
                     factory_path = factory_path,
                     factory_window_title = factory_window_title,
                     parent = parent),
                list(...)
            )
        )

        if(!is.null(linkingGroup)) {
            l_configure(plot,
                        linkingGroup = linkingGroup,
                        sync = sync)
        }

        class(plot) <- c(type, class(plot))
        return(plot)
    }

    # set parent
    if(is.null(parent)) {
        # create parent
        parent <- l_toplevel()
        subwin <- l_subwin(parent, 'facet')

        tktitle(parent) <- paste("loon facets on",
                                 deparse(substitute(by_names)), "--path:", subwin)
        # create child
        child <- as.character(tcl('frame', subwin))
    } else {
        child <- parent
    }

    # linkingGroup
    if(is.null(linkingGroup)) {
        linkingGroup <- paste0("facet", valid_path())
        print(paste("linkingGroup:", linkingGroup))
    }

    plots <- lapply(splitted_data,
                    function(d) {

                        d <- d[ , !(names(d) %in% by_names)]

                        if(dim(d)[1] == 0) {

                            loonPlotFactory(
                                factory_tclcmd = factory_tclcmd,
                                factory_path = factory_path,
                                factory_window_title = factory_window_title,
                                parent = child,
                                xlabel = "",
                                ylabel = "",
                                title = "",
                                minimumMargins = rep(5, 4),
                                ...
                            )

                        } else {

                            oneDimArgs$minimumMargins <- rep(5, 4)
                            oneDimArgs$xlabel <- ""
                            oneDimArgs$ylabel <- ""
                            oneDimArgs$title <- ""

                            do.call(
                                loonPlotFactory,
                                c(
                                    as.list(d),
                                    oneDimArgs,
                                    list(factory_tclcmd = factory_tclcmd,
                                         factory_path = factory_path,
                                         factory_window_title = factory_window_title,
                                         parent = child),
                                    list(...)
                                )
                            )
                        }
                    })

    if(!is.null(oneDimArgs$title)) title <- oneDimArgs$title

    if(facet == "grid") {

        ## Two major objectives here
        # 1. pack plots and labels
        # 2. rename and reorder plots
        plots <- do.call(
            facet_grid_layout,
            c(
                by_args,
                list(plots = plots,
                     subtitles = subtitles,
                     parent = child,
                     xlabel = xlabel,
                     ylabel = ylabel,
                     title = title
                )
            )
        )

        # forbidden swapAxes showScales and showLabels
        facet_forbiddenSetting(plots,
                               child = child,
                               showLabels = TRUE, showScales = FALSE,
                               swapAxes = ifelse(is.null(oneDimArgs$swapAxes), FALSE, oneDimArgs$swapAxes))

        # synchronize
        facet_grid_synchronizeSetting(plots, child = child)

        # set class and linkingGroup for each plot
        plots <- lapply(plots,
                        function(plot) {
                            l_configure(plot,
                                        linkingGroup = linkingGroup,
                                        sync = sync)
                            structure(plot, class = c(type, class(plot)))
                        })

        structure(
            plots,
            class = c("l_facet_grid", "l_facet", "l_compound", "loon")
        )

    } else {

        plots <- do.call(
            facet_wrap_layout,
            c(
                by_args,
                list(plots = plots,
                     subtitles = subtitles,
                     parent = child,
                     xlabel = xlabel,
                     ylabel = ylabel,
                     title =  title
                )
            )
        )

        # forbidden swapAxes showScales and showLabels
        facet_forbiddenSetting(plots,
                               child = child,
                               showLabels = TRUE, showScales = FALSE,
                               swapAxes = ifelse(is.null(oneDimArgs$swapAxes), FALSE, oneDimArgs$swapAxes))

        scales <- by_args$scales
        scales <- if(is.null(scales)) {
            "fixed"
        } else {
            switch(scales,
                   "fixed_x" = "free_y",
                   "fixed_y" = "free_x",
                   {
                       scales
                   })
        }

        xrange <- c()
        yrange <- c()
        lapply(plots,
               function(p) {
                   xrange <<- c(xrange, p['panX'], p['panX'] + p['deltaX']/p['zoomX'])
                   yrange <<- c(yrange, p['panY'], p['panY'] + p['deltaY']/p['zoomY'])
               })
        xrange <- extendrange(xrange)
        yrange <- extendrange(yrange)


        facet_wrap_synchronizeSetting(plots, child = child, scales = scales,
                                      xrange = xrange, yrange = yrange)

        # set class and linkingGroup for each plot
        plots <- lapply(plots,
                        function(plot) {
                            l_configure(plot,
                                        linkingGroup = linkingGroup,
                                        sync = sync)
                            structure(plot, class = c(type, class(plot)))
                        })

        structure(
            plots,
            class = c("l_facet_wrap", "l_facet", "l_compound", "loon")
        )
    }
}

loonFacets.l_serialaxes <- function(type,
                                    by,
                                    args,
                                    facet = "grid",
                                    by_args, linkingGroup, sync, parent,
                                    factory_tclcmd, factory_path,
                                    factory_window_title,
                                    xlabel = "", ylabel = "", title = "", ...) {

    by_names <- colnames(by)

    args$by <- by
    args <- l_na_omit(type[1], args,
                      n_dim_states = c(l_nDimStateNames(type[1]),
                                       "by"))
    # remove 'by' from args
    by <- setNames(as.data.frame(args$by, stringsAsFactors = FALSE), by_names)
    args$by <- NULL

    ## get N dimensional data frame
    # what is the n?
    x <- args[["x"]]
    N <- if(is.null(x)) {
        # serialaxes?
        x <- args[["data"]]
        if(is.null(x)) integer(0) else dim(x)[1]
    } else {
        length(x)
    }
    # N dim args
    data <- cbind(index = 1:N, as.data.frame(args[which(lengths(args) == N)], stringsAsFactors = FALSE), by)

    serialaxesData <- args$data
    # 1 dim args
    args$data <- NULL
    oneDimArgs <- args[which(lengths(args) != N)]

    subtitles <- setNames(lapply(by, function(b) as.character(levels(factor(b)))), by_names)

    # split data by "by"
    splitted_data <- split(data, f = as.list(by), drop = FALSE, sep = "*")

    if(length(splitted_data) == 1) {

        plot <- do.call(
            loonPlotFactory,
            c(
                args,
                list(factory_tclcmd = factory_tclcmd,
                     factory_path = factory_path,
                     factory_window_title = factory_window_title,
                     parent = parent,
                     data = l_data(serialaxesData)),
                list(...)
            )
        )

        if(!is.null(linkingGroup)) {
            l_configure(plot,
                        linkingGroup = linkingGroup,
                        sync = sync)
        }

        class(plot) <- c(type, class(plot))
        return(plot)
    }

    # set parent
    if(is.null(parent)) {
        # create parent
        parent <- l_toplevel()
        subwin <- l_subwin(parent, 'facet')

        tktitle(parent) <- paste("loon facets on",
                                 deparse(substitute(by_names)), "--path:", subwin)
        # create child
        child <- as.character(tcl('frame', subwin))
    } else {
        child <- parent
    }

    # linkingGroup
    if(is.null(linkingGroup)) {
        linkingGroup <- paste0("facet", valid_path())
        print(paste("linkingGroup:", linkingGroup))
    }

    plots <- lapply(splitted_data,
                    function(d) {

                        d <- d[ , !(names(d) %in% by_names)]

                        if(dim(d)[1] == 0) {

                            loonPlotFactory(
                                factory_tclcmd = factory_tclcmd,
                                factory_path = factory_path,
                                factory_window_title = factory_window_title,
                                parent = child,
                                title = "",
                                ...
                            )

                        } else {

                            oneDimArgs$xlabel <- NULL
                            oneDimArgs$ylabel <- NULL
                            oneDimArgs$title <- NULL

                            index <- d$index
                            d$index <- NULL

                            do.call(
                                loonPlotFactory,
                                c(
                                    as.list(d),
                                    oneDimArgs,
                                    list(factory_tclcmd = factory_tclcmd,
                                         factory_path = factory_path,
                                         factory_window_title = factory_window_title,
                                         parent = child,
                                         title = "",
                                         data = l_data(serialaxesData[index, ])),
                                    list(...)
                                )
                            )
                        }
                    })

    if(!is.null(oneDimArgs$title)) title <- oneDimArgs$title

    if(facet == "grid") {

        ## Two major objectives here
        # 1. pack plots and labels
        # 2. rename and reorder plots
        plots <- do.call(
            facet_grid_layout,
            c(
                by_args,
                list(plots = plots,
                     subtitles = subtitles,
                     parent = child,
                     xlabel = xlabel,
                     ylabel = ylabel,
                     title = title
                )
            )
        )

        # set class and linkingGroup for each plot
        plots <- lapply(plots,
                        function(plot) {
                            l_configure(plot,
                                        linkingGroup = linkingGroup,
                                        sync = sync)
                            structure(plot, class = c(type, class(plot)))
                        })

        structure(
            plots,
            class = c("l_facet_grid", "l_facet", "l_compound", "loon")
        )

    } else {

        plots <- do.call(
            facet_wrap_layout,
            c(
                by_args,
                list(plots = plots,
                     subtitles = subtitles,
                     parent = child,
                     xlabel = xlabel,
                     ylabel = ylabel,
                     title =  title
                )
            )
        )

        # set class and linkingGroup for each plot
        plots <- lapply(plots,
                        function(plot) {
                            l_configure(plot,
                                        linkingGroup = linkingGroup,
                                        sync = sync)
                            structure(plot, class = c(type, class(plot)))
                        })

        structure(
            plots,
            class = c("l_facet_wrap", "l_facet", "l_compound", "loon")
        )
    }
}