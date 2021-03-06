## TODO: write R functions to import jpgs and pngs if Img tcl extension could not be loaded

#' @title Import Image Files as Tk Image Objects
#'   
#' @description Note that the supported image file formats depend on whether the
#'   \code{Img} Tk extension is installed.
#'   
#' @param paths vector with paths to image files that are supported
#' 
#' @templateVar page learn_R_display_plot
#' @templateVar section load-images
#' @template see_l_help
#'  
#' 
#' @return vector of image object names
#'   
#' @seealso \code{\link{l_image_import_array}}, \code{\link{l_imageviewer}}
#'   
#' @export
l_image_import_files <- function(paths) {

    if (!.withTclImg) {
        if (any(vapply(paths, function(p) {
            !(toupper(tools::file_ext(p)) %in% c("PPM", "PGM", "PNG", "GIF"))
        }, logical(1)))) {
            stop("All file formats other than png require the IMG Tcl extension.")    
        }
    }
    
    unique_paths <- unique(paths)
    unique_ids <- sapply(unique_paths, function(path) {
        tclvalue(tkimage.create('photo', file = path))	
    })
    ii <- match(paths,unique_paths)
    
    return(unique_ids[ii])
}
