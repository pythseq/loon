import pandas as pd
import numpy as np
from itertools import combinations,compress
from functools import singledispatch
from .retrieve_name import retrieve_name
from .l_plot import l_plot
from .l_hist import l_hist
from .l_layer import *
from .l_serialaxes import l_serialaxes
from .l_toplevel import l_toplevel
from .l_subwin import l_subwin
from .tk import tk
from .helper import *
from .loon_class import loon_l_pairs
from .l_compound import l_getPlots,l_getLocations
from .l_throwErrorIfNotLoonWidget import l_throwErrorIfNotLoonWidget
from .l_export import exportImageDialog
from .l_configure import l_configure

def l_pairs(data, linkingGroup = None, linkingKey = None, showItemLabels = True, itemLabel = None,
                    showHistograms = False, histLocation = "edge",
                    histHeightProp = 1, histArgs = {},
                    showSerialAxes = False, serialAxesArgs = {}, parent=None, **args):
    '''An interactive scatterplot matrix

    Function creates a scatterplot matrix using loon's scatterplot
    widgets

    Args:
        data: a pandas dataFrame with numerical(or categorical) data to create the scatterplot matrix
        linkingGroup: string giving the linkingGroup for all plots.  If missing,
                      a default `linkingGroup` will be determined from deparsing the `data`.
        linkingKey: a vector of strings to provide a linking identity for each row of the
                    `data`.  If missing, a default `linkingKey` will be `0:(data.shape[0]-1)`.
        showItemLabels: True, logical indicating whether its itemLabel pops up over a point when
                        the mouse hovers over it.
        itemLabel: a list of strings to be used as pop up information when the mouse hovers
                    over a point.  If missing, the default `itemLabel` will be the `data.index`.
        showHistograms: logical (default False) to show histograms of each variable or not
        histLocation: one "edge" or "diag", when showHistograms = True
        histHeightProp: a positive number giving the height of the histograms as a
                        proportion of the height of the scatterplots
        histArgs: additional arguments to modify the `l_hist` states
        showSerialAxes: logical (default False) indication of whether to show a serial axes plot
                        in the bottom left of the pairs plot (or not)
        serialAxesArgs: additional arguments to modify the `l_serialaxes` states
        **args: named arguments to modify the `l_plot` states of the scatterplots

    Returns:
        an `loon_l_pairs` class (an `l_compound` object)

    See Also:
        `l_plot` and `l_getPlots`

    Examples:
        >>> p = l_pairs(iris.iloc[:,0:4], color=iris.Species, linkingGroup = "iris")
        >>> p = l_pairs(iris.iloc[:,0:4], color=iris.Species, linkingGroup = "iris",showHistograms = True, showSerialAxes = True)
        >>> # plot names
        >>> p.names
        >>> # Each plot must be accessed to make changes not managed through
        >>> # linking.
    '''
    
    def undoScatterStateChanges(W):
        Warning("showLabels, showScales, and swapAxes can not be changed for scatterplot matrix.")
        l_configure(W, showLabels = False, showScales = False, swapAxes = False)


    def undoHistStateChanges(W):
        Warning("showLabels, showScales can not be changed for scatterplot matrix.")
        l_configure(W, showLabels = False, showScales = False)
    
    if(not isinstance(data,pd.DataFrame)):
        exit('Require pandas dataframe data')
    dataname = retrieve_name(data)
    if(len(dataname) > 0):
        dataname = dataname[0]
    else:
        dataname = ''
    
    if (linkingGroup == None):
        linkingGroup = "l_pairs_" + dataname
    # Use default as in tcl/tk
    if (linkingKey == None):
        linkingKey = []
    
    if (itemLabel == None):
        itemLabel = list(data.index)
    
    if (len(itemLabel) != data.shape[0]):
        Warning("itemLabel length not equal to number of observations, using row.names(data) instead")
        itemLabel = list(data.index)

    args['x'] = None
    args['y'] = None
    args['linkingGroup'] = linkingGroup
    args['linkingKey'] = linkingKey
    args['itemLabel'] = itemLabel
    args['showItemLabels'] = showItemLabels

    if (data.shape[1] < 2 ):
        args['x'] = data
        args['parent'] = parent
        return l_plot(**args)
    

    args['showLabels'] = False
    args['showScales'] = False
    args['swapAxes'] = False

    new_toplevel = False

    if(parent==None):
        new_toplevel = True
        parent = l_toplevel()
        title = "loon scatterplot matrix for "+ dataname +  " data"
        tk.tk.call('wm','title',parent,title)
    child = str(tk.tk.call('frame', l_subwin(parent, 'pairs')))

    ## parent for individual scatterplots
    args['parent'] = child

    nvar = data.shape[1]
    pair = np.array(list(combinations(range(nvar),2))).transpose()
    varnames = list(data.columns)

    # combn returns the variable combinations for the scatterplot
    # matrix. The scatterplot arrangements is as follows
    #
    #      0      1      2      3
    #  0  [0]   (1,0)  (2,0)  (3,0)
    #  1         [1]   (2,1)  (3,1)
    #  2                [2]   (3,2)
    #  3                       [3]
    #
    #
    # pair is
    #  0  0  0  1  1  2
    #  1  2  3  2  3  3

    cells = nvar 
    text_adjustValue = 1
    scatter_adjustValue = 0
    span = 1
    if(histLocation != 'edge'):
        histLocation_opt = ['edge','diag']
        histLocation = match_arg(histLocation,histLocation_opt,'histLocation')
    
    if (showHistograms):
        if('showStackedColors' not in histArgs.keys()): 
            histArgs['showStackedColors'] = True
        if('showOutlines' not in histArgs.keys()):
            histArgs['showOutlines'] = False
        if('yshows' not in histArgs.keys()):
            histArgs['yshows'] =  "density"
        if('showBinHandle' not in histArgs.keys()):
            histArgs['showBinHandle'] = False
        
        # histArgs is consistent with args
        histArgs['showLabels'] = args['showLabels'] if 'showLabels' in args.keys() else histArgs['showLabels'] 
        histArgs['showScales'] = args['showScales'] if 'showScales' in args.keys() else histArgs['showScales'] 
        histArgs['parent'] = args['parent'] if 'parent' in args.keys() else histArgs['parent'] 
        histArgs['linkingGroup'] = args['linkingGroup'] if 'linkingGroup' in args.keys() else histArgs['linkingGroup'] 
        histArgs['linkingKey'] = args['linkingKey'] if 'linkingKey' in args.keys() else histArgs['linkingKey'] 
        #histograms = []
        histograms = {}
        if(histLocation == "edge"):
            span = 1 if round(1/histHeightProp) >= 1 else round(1/histHeightProp)
            # The first half are top hists, the second half are right hists
            for i in range(2*nvar):
                if (i < nvar):
                    histArgs['x'] = asnumeric(data[varnames[i]])
                    histArgs['xlabel'] = varnames[i]
                    # top level histograms
                    histArgs['swapAxes'] = False
                    ix = i
                    iy = 0
                else:
                    histArgs['x'] = asnumeric(data[varnames[i - nvar]])
                    histArgs['xlabel'] = varnames[i - nvar]
                    # right level histograms
                    histArgs['swapAxes'] = True
                    ix = nvar 
                    iy = i - nvar + 1
                #histograms.append(l_hist(**histArgs))
                #names(histograms)[i] <- paste('x',ix,'y',iy, sep="")
                histograms['x' + str(ix) + 'y' + str(iy)] = l_hist(**histArgs)
            # throw errors
            # if (any(sapply(histograms, function(p) {is(p, 'try-error')}))) {
            #     if(new.toplevel) tkdestroy(parent)
            #     stop("histogram could not be created.")
            # }
            def tempf(i):
                #h = histograms[i]
                h = list(histograms.values())[i]
                if(i < nvar):
                    tk.tk.call(h.plot+'.canvas','configure','-width',50,'-height',50*histHeightProp)
                else:
                    tk.tk.call(h.plot+'.canvas','configure','-width',50*histHeightProp,'-height',50)
            
            list(map(tempf,range(2*nvar)))
            # grid layout
            def tempf2(i):
                if(i < nvar):
                    tk.tk.call('grid',list(histograms.values())[i].plot,'-row',0,'-column', i * span,'-rowspan', 1,'-columnspan', span,'-sticky', "nesw")
                else:
                    tk.tk.call('grid',list(histograms.values())[i].plot,'-row',1+ (i - nvar)* span,'-column', nvar * span, '-rowspan', span, '-columnspan', 1,'-sticky',"nesw")
            list(map(tempf2, range(1,(2*nvar-1))))

            cells = nvar
            text_adjustValue = 0
            scatter_adjustValue = 1
        else:
            if(histHeightProp != 1):
                Warning("histHeightProp must be 1 when histograms are placed on diagonal")
            for i in range(nvar):
                histArgs['x'] = asnumeric(data[varnames[i]])
                histArgs['xlabel'] = varnames[i]
                histArgs['swapAxes'] = False
                histograms['x'+str(i) +'y' + str(i)] = l_hist(**histArgs)
                xText = list(histograms.values())[i]['panX'] + list(histograms.values())[i]['deltaX']/(2*list(histograms.values())[i]['zoomX'])
                yText = list(histograms.values())[i]['panY'] + list(histograms.values())[i]['deltaY']/(2*list(histograms.values())[i]['zoomY'])
                layerText = l_layer_text(list(histograms.values())[i], xText, yText, text = varnames[i],
                                          color = "black", size = 8)
                #names(histograms)[i] <- paste('x',i,'y',i, sep="")
            
            # throw errors
            # if (any(sapply(histograms, function(p) {is(p, 'try-error')}))) {
            #     if(new.toplevel) tkdestroy(parent)
            #     stop("histogram could not be created.")
            # }

            def tempf3(i):
                h = list(histograms.values())[i]
                tk.tk.call(h.plot+'.canvas','configure','-width',50,'-height',50)
            list(map(tempf3,range(nvar)))

            # grid layout
            def tempf4(i):
                tk.tk.call('grid',list(histograms.values())[i].plot,'-row',i, '-column', i,'-rowspan', span, '-columnspan', span, '-sticky', 'nesw')
            list(map(tempf4,range(nvar)))


    if (showSerialAxes):
        serialAxesArgs['data'] = data
        serialAxesArgs['axesLayout'] = "parallel"
        serialAxesArgs['showLabels'] = args['showLabels']
        serialAxesArgs['parent'] = args['parent']
        serialAxesArgs['linkingGroup'] = args['linkingGroup']
        serialAxesArgs['linkingKey'] = args['linkingKey']
        serialAxesArgs['itemLabel'] = args['itemLabel']
        serialAxesArgs['showItemLabels'] = args['showItemLabels']
        serialAxesSpan = int(nvar/2)
        serialAxes = l_serialaxes(**serialAxesArgs)
        tk.tk.call(serialAxes.plot+'.canvas','configure','-width', serialAxesSpan * 50,'-height', serialAxesSpan * 50)
        tk.tk.call('grid',serialAxes.plot,'-row', (cells - serialAxesSpan) * span + 1, '-column', 0,'-rowspan', serialAxesSpan * span, '-columnspan', serialAxesSpan * span,'-sticky',"nesw")
    #scatterplots = []
    scatterplots = {}
    ## create first plot
    for i in range(pair.shape[1]):
        ix = pair[1,i]
        iy = pair[0,i]

        args['xlabel'] = varnames[ix]
        args['ylabel'] = varnames[iy]

        args['x'] = asnumeric(data[varnames[ix]])
        args['y'] = asnumeric(data[varnames[iy]])

        #scatterplots.append(l_plot(**args))
        if(showHistograms and histLocation == 'edge'):
            scatterplots['x' + str(ix) + 'y' + str(iy+1)] = l_plot(**args)
        else:
            scatterplots['x' + str(ix) + 'y' + str(iy)] = l_plot(**args)
        # reset names (if showHistograms)
        # if (showHistograms and histLocation == "edge") {
        #     names(scatterplots)[i] <- paste('x',ix,'y',iy + 1, sep="")
        # } else {
        #     names(scatterplots)[i] <- paste('x',ix,'y',iy, sep="")
        # }

    # if (any(sapply(scatterplots, function(p) {is(p, 'try-error')}))) {
    #     if(new.toplevel) tkdestroy(parent)
    #     stop("scatterplot matrix could not be created.")
    # }

    ## resize the min canvas size
    def tempf5(p):
        tk.tk.call(p.plot + '.canvas','configure','-width',50,'-height',50)
    list(map(tempf5,scatterplots.values()))


    ## grid layout
    def tempf6(i):
        tk.tk.call('grid',list(scatterplots.values())[i].plot,'-row',pair[0,i]*span + scatter_adjustValue,'-column', pair[1,i]*span, '-rowspan', span, '-columnspan', span,'-sticky','nesw')
    list(map(tempf6,range(len(scatterplots))))
    
    ## Column and Row wheight such that the cells expand
    for i in range(cells):
        tk.tk.call('grid','columnconfigure',child,i,'-weight',1)
        tk.tk.call('grid','rowconfigure',child,i,'-weight',1)
        
    ## Add Variable Label
    if (not showHistograms or (showHistograms and histLocation == "edge")):
        maxchar = max([len(x) for x in varnames])
        strf = "%-" +  str(maxchar) + 's'
        for i in range(nvar):
            lab = tk.tk.call('label', l_subwin(child,'label'),'-text',varnames[i])
            tk.tk.call('grid',lab,'-row',(i - text_adjustValue) * span + 1,'-column',i * span,'-rowspan', span,'-columnspan', span)

    if(new_toplevel):
        tk.tk.call('pack',child,'-fill','both','-expand',1)
    # plotsHash <- vector(mode="list", dim(pair)[2])
    plotsHash = {}
    for i in range(pair.shape[1]):
        ix = pair[1,i]
        iy = pair[0,i]

        tmpX = np.argwhere(pair[1,] == ix)
        shareX = tmpX[tmpX != i]

        tmpY = np.argwhere(pair[0,] == iy)
        shareY = tmpY[tmpY != i]

        #plotsHash[[paste("scatter_y_",
        #                 scatterplots[i],
        #                 sep="")]] <- scatterplots[shareY]
        plotsHash['scatter_y_' + list(scatterplots.values())[i].plot] = list(map(list(scatterplots.values()).__getitem__,shareY))
        if(showHistograms):
            plotsHash["scatter_x_" + list(scatterplots.values())[i].plot] = list(map(list(scatterplots.values()).__getitem__,shareX)) + [list(histograms.values())[pair[1,i]]]
            if(histLocation == "edge"):
                plotsHash["swap_hist_"+list(scatterplots.values())[i].plot] = list(histograms.values())[pair[1,i] + nvar]
            else:
                plotsHash["swap_hist_"+list(scatterplots.values())[i].plot] = list(histograms.values())[pair[1,i]]
        else:
            plotsHash["scatter_x_"+list(scatterplots.values())[i].plot] = list(map(list(scatterplots.values()).__getitem__,shareX))
        
        

    ## Make bindings for scatter synchronizing zoom and pan
    busy = {'status':False}
    def synchronizeScatterBindings(W):       
        if (not busy['status']):
            busy['status'] = True
            if(not isinstance(W,loon)):
                W = loon(W)
            # class(W) <- "loon"
            zoomX = W['zoomX']
            zoomY = W['zoomY']
            panX = W['panX']
            panY = W['panY']
            deltaX = W['deltaX']
            deltaY = W['deltaY']
            list(map(lambda p: l_configure(p,zoomX=zoomX,panX=panX,deltaX=deltaX), plotsHash["scatter_x_"+W.plot]))            
            list(map(lambda p: l_configure(p,zoomY=zoomY,panY=panY,deltaY=deltaY), plotsHash["scatter_y_"+W.plot]))
            if (showHistograms):
                map(lambda p: l_configure(p, zoomX=zoomY, panX=panY, deltaX=deltaY),plotsHash["swap_hist_"+W.plot])
            # tk.tk.call('update', 'idletasks')        
            busy['status'] = False
    synchronizeScatterBindings_tcl = tk._register(synchronizeScatterBindings)
    list(map(lambda p: tk.tk.call(p.plot,'systembind', 'state', 'add',
                    ['zoomX', 'panX', 'zoomY', 'panY', 'deltaX', 'deltaY'],
                    [synchronizeScatterBindings_tcl,p.plot]),scatterplots.values()))
    
    # forbidden scatter plots
    # synchronize
    undoScatterStateChanges_tcl = tk._register(undoScatterStateChanges)
    list(map(lambda p: tk.tk.call(p.plot,'systembind', 'state', 'add',
                        ['showLabels', 'showScales', 'swapAxes'],
                        [undoScatterStateChanges_tcl,p.plot]),scatterplots.values()))

    plots = scatterplots
    # names must follow the pattern xayb, (a,b) is the coords of the corresponding layout
    def xy_layout(names):
        xpos = [x.find('x') for x in names]
        ypos = [y.find('y') for y in names]
        len_char = [len(x) for x in names]
        x = [int(names[i][xpos[i]+1:ypos[i]]) for i in range(len(xpos))]
        y = [int(names[i][ypos[i]+1:len_char[i]]) for i in range(len(ypos))]
        return {'x':x,'y':y}

    if (showHistograms):
        # synchronize hist bindings
        histsHash = {}
        namesHist =  list(histograms.keys())
        namesScatter = list(scatterplots.keys())

        scatterLayout = xy_layout(namesScatter)
        scatterX = scatterLayout['x']
        scatterY = scatterLayout['y']

        if(histLocation == "edge"):
            for i in range(len(histograms)):
                nameHist = namesHist[i]
                if(i != 0 and i != len(histograms)):
                    if(i < nvar):
                        histX = xy_layout([nameHist])['x'][0]
                        shareX = [x == histX for x in scatterX]
                        histsHash["hist_x_"+ list(histograms.values())[i].plot] =list(compress(list(scatterplots.values()),shareX))
                    else:
                        histY = xy_layout([nameHist])['y'][0]
                        shareY = [y == histY for y in scatterY]
                        histsHash["hist_y_" + list(histograms.values())[i].plot]= list(compress(list(scatterplots.values()),shareY))
        else:
            for i in range(len(histograms)):
                nameHist = namesHist[i]
                histLayout = xy_layout([nameHist])
                histX = histLayout['x'][0]
                histY <- histLayout['y'][0]
                shareX = [x == histX for x in scatterX]
                shareY = [y == histY for y in scatterY]
                if(len(shareX) > 0):
                    histsHash["hist_x_"+ list(histograms.values())[i].plot] =list(compress(list(scatterplots.values()),shareX))
                if(len(shareY) > 0):
                    histsHash["hist_y_" + list(histograms.values())[i].plot]= list(compress(list(scatterplots.values()),shareY))
        def synchronizeHistBindings(W):
            #print(paste(W, ', busy', busy))
            if (not busy['status']):
                busy['status'] = True
                if(not isinstance(W,loon)):
                    W = loon(W)
                zoomX = W['zoomX']
                zoomY = W['zoomY']
                panX = W['panX']
                panY = W['panY']
                deltaX = W['deltaX']
                deltaY = W['deltaY']
                if("hist_x_"+W.plot in histsHash.keys()):
                    list(map(lambda h: l_configure(h,zoomX=zoomX,panX=panX,deltaX=deltaX), histsHash["hist_x_"+W.plot]))            
                if("hist_y_"+W.plot in histsHash.keys()):
                    list(map(lambda h: l_configure(h,zoomY=zoomY,panY=panY,deltaY=deltaY), histsHash["hist_y_"+W.plot]))
                busy['status'] = False
                #tk.tk.call('update', 'idletasks')
        synchronizeHistBindings_tcl = tk._register(synchronizeHistBindings)
        # synchronize
        list(map(lambda h: tk.tk.call(h.plot,'systembind', 'state', 'add',
                        ['zoomX', 'panX', 'zoomY', 'panY', 'deltaX', 'deltaY'],
                        [synchronizeHistBindings_tcl,h.plot]),histograms.values()))   
        # forbidden
        undoHistStateChanges_tcl = tk._register(undoHistStateChanges)
        list(map(lambda h: tk.tk.call(h.plot,'systembind', 'state', 'add',
                            ['showLabels', 'showScales'],
                            undoHistStateChanges_tcl),histograms.values()))  
        plots.update(histograms) 


    if(showSerialAxes):
        #plots <- c(plots, list(serialAxes = serialAxes))
        plots['serialAxes'] = serialAxes
    plots = loon_l_pairs(plots)
    def temp():
            exportImageDialog(parent)
        ## Bind Ctrl-P to export image
        #temp_f = tk._register(temp)
    tk.tk.createcommand('temp_f',temp)
    tk.tk.call("bind", parent, "<Control-KeyPress-p>",'temp_f')
    return plots


@l_getPlots.register
def _(target:loon_l_pairs):
    #throw errors if elements of compound are a not loon widget
    [l_throwErrorIfNotLoonWidget(x) for x in target.plot.values()]
    return dict(target.plot.items())


#' @rdname l_getLocations
#'
#' @export
@l_getLocations.register
def _(target: loon_l_pairs):
    nPlots = len(target.plot)
    nScatterplots = nHistograms = nSerialAxes = 0
    scatterplots = histograms = serialAxes = []
    plotNames = target.plot.keys()
    return 0
#     for i in range(nPlors):

# #     for(i in 1:nPlots) {
# #         if("l_plot" %in% class(target[[i]])) {
# #             nScatterplots <- nScatterplots + 1
# #             scatterplots[[nScatterplots]] <- target[[i]]
# #             names(scatterplots)[nScatterplots] <- plotNames[i]
# #         }
# #         if("l_hist" %in% class(target[[i]])) {
# #             nHistograms <- nHistograms + 1
# #             histograms[[nHistograms]] <- target[[i]]
# #             names(histograms)[nHistograms] <- plotNames[i]
# #         }
# #         if("l_serialaxes" %in% class(target[[i]])) {
# #             nSerialAxes <- nSerialAxes + 1
# #             serialAxes[[nSerialAxes]] <- target[[i]]
# #             names(serialAxes)[nSerialAxes] <- plotNames[i]
# #         }
# #     }

# #     nvar <- (-1 + sqrt(1 + 8 * nScatterplots)) / 2 + 1
# #     showSerialAxes <- (nSerialAxes > 0)
# #     showHistograms <- (nHistograms > 0)

# #     if(showHistograms) {
# #         histLocation <- if(nHistograms == (nvar - 1) * 2) "edge" else "diag"
# #         if(histLocation == "edge") {
# #             cells <- nvar + 1
# #         } else {
# #             cells <- nvar
# #         }
# #     } else {
# #         cells <- nvar
# #     }

# #     layout_matrix <- matrix(rep(NA, (cells)^2), nrow = cells)
# #     scatter_hist <- c(scatterplots, histograms)

# #     for(i in 1:length(scatter_hist)) {
# #         nameOfScatter_hist <- names(scatter_hist[i])
# #         pos <- xy_layout(nameOfScatter_hist)
# #         layout_matrix[pos$y, pos$x] <- i
# #     }

# #     if(showSerialAxes) {
# #         serialAxesSpan <- floor(nvar/2)
# #         # square space
# #         for(i in 1:serialAxesSpan) {
# #             for(j ina 1:serialAxesSpan) {
# #                 layout_matrix[cells - serialAxesSpan + i, j] <- nScatterplots + nHistograms + 1
# #             }
# #         }
# #     }

# #     list(
# #         nrow = cells,
# #         ncol = cells,
# #         layout_matrix = layout_matrix,
# #         heights = rep(1, cells),
# #         widths = rep(1, cells)
# #     )
# # }

