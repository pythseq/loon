package ifneeded loon 1.0.1 "
   package provide loon 1.0.1 
   package require Tcl 8.6 
   package require Tk 8.6 
   [list set ::env(LOON_VERSION) 0.1]
   [list set ::env(LOON_LIBRARY) [file dirname [info script]]]
   [list source [file join $dir library/init.tcl]]
   [list source [file join $dir library/listfns.tcl]]
   [list source [file join $dir library/hcl.tcl]]
   [list source [file join $dir library/optionDatabase.tcl]]
   [list source [file join $dir library/oo_fancyInfo.tcl]]
   [list source [file join $dir library/oo_Configurable.tcl]]
   [list source [file join $dir library/oo_Configurable_Check.tcl]]
   [list source [file join $dir library/oo_Bindable.tcl]]
   [list source [file join $dir library/oo_withStateBindings.tcl]]
   [list source [file join $dir library/oo_withCanvasAndItemBindings.tcl]]
   [list source [file join $dir library/oo_VariableDimensions.tcl]]
   [list source [file join $dir library/oo_Linkable.tcl]]
   [list source [file join $dir library/oo_withLayers.tcl]]
   [list source [file join $dir library/oo_LabelledCollection.tcl]]
   [list source [file join $dir library/oo_withItemLabels.tcl]]
   [list source [file join $dir library/oo_withGlyphs.tcl]]
   [list source [file join $dir library/oo_Plot_Model.tcl]]
   [list source [file join $dir library/oo_XYPair_Model.tcl]]
   [list source [file join $dir library/oo_Scatterplot_Model.tcl]]
   [list source [file join $dir library/oo_Bindings.tcl]]
   [list source [file join $dir library/oo_StateBindings.tcl]]
   [list source [file join $dir library/oo_CollectionBindings.tcl]]
   [list source [file join $dir library/oo_LayerBindings.tcl]]
   [list source [file join $dir library/oo_ItemBindings.tcl]]
   [list source [file join $dir library/oo_CanvasBindings.tcl]]
   [list source [file join $dir library/oo_Layer.tcl]]
   [list source [file join $dir library/oo_GroupLayer.tcl]]
   [list source [file join $dir library/oo_PrimitiveLayer.tcl]]
   [list source [file join $dir library/oo_PrimitiveLayer1.tcl]]
   [list source [file join $dir library/oo_PrimitiveLayerN.tcl]]
   [list source [file join $dir library/oo_PolygonLayer.tcl]]
   [list source [file join $dir library/oo_PolygonsLayer.tcl]]
   [list source [file join $dir library/oo_RectangleLayer.tcl]]
   [list source [file join $dir library/oo_RectanglesLayer.tcl]]
   [list source [file join $dir library/oo_OvalLayer.tcl]]
   [list source [file join $dir library/oo_PointsLayer.tcl]]
   [list source [file join $dir library/oo_TextLayer.tcl]]
   [list source [file join $dir library/oo_TextsLayer.tcl]]
   [list source [file join $dir library/oo_LineLayer.tcl]]
   [list source [file join $dir library/oo_LinesLayer.tcl]]
   [list source [file join $dir library/oo_ModelLayer.tcl]]
   [list source [file join $dir library/oo_ScatterplotLayer.tcl]]
   [list source [file join $dir library/oo_GraphLayer.tcl]]
   [list source [file join $dir library/oo_Visual.tcl]]
   [list source [file join $dir library/oo_BoxVisual.tcl]]
   [list source [file join $dir library/oo_LabelsVisual.tcl]]
   [list source [file join $dir library/oo_BorderVisual.tcl]]
   [list source [file join $dir library/oo_ScalesGuidesVisual.tcl]]
   [list source [file join $dir library/oo_LayerVisual.tcl]]
   [list source [file join $dir library/oo_LayerVisual1.tcl]]
   [list source [file join $dir library/oo_LayerVisualN.tcl]]
   [list source [file join $dir library/oo_PolygonVisual.tcl]]
   [list source [file join $dir library/oo_PolygonsVisual.tcl]]
   [list source [file join $dir library/oo_RectangleVisual.tcl]]
   [list source [file join $dir library/oo_RectanglesVisual.tcl]]
   [list source [file join $dir library/oo_OvalVisual.tcl]]
   [list source [file join $dir library/oo_TextVisual.tcl]]
   [list source [file join $dir library/oo_PointsVisual.tcl]]
   [list source [file join $dir library/oo_LineVisual.tcl]]
   [list source [file join $dir library/oo_LinesVisual.tcl]]
   [list source [file join $dir library/oo_TextsVisual.tcl]]
   [list source [file join $dir library/oo_ScatterplotVisual.tcl]]
   [list source [file join $dir library/oo_ScatterplotWorldviewVisual.tcl]]
   [list source [file join $dir library/oo_PointsWorldviewVisual.tcl]]
   [list source [file join $dir library/oo_GraphVisual.tcl]]
   [list source [file join $dir library/oo_GraphWorldviewVisual.tcl]]
   [list source [file join $dir library/oo_NavigatorVisual.tcl]]
   [list source [file join $dir library/oo_NavigatorWorldviewVisual.tcl]]
   [list source [file join $dir library/oo_GlyphVisual.tcl]]
   [list source [file join $dir library/oo_ImageGlyphVisual.tcl]]
   [list source [file join $dir library/oo_PointrangeGlyphVisual.tcl]]
   [list source [file join $dir library/oo_SerialaxesGlyphVisual.tcl]]
   [list source [file join $dir library/oo_SpiroGlyphVisual.tcl]]
   [list source [file join $dir library/oo_PolygonGlyphVisual.tcl]]
   [list source [file join $dir library/oo_TextGlyphVisual.tcl]]
   [list source [file join $dir library/oo_colormenu.tcl]]
   [list source [file join $dir library/oo_linkingGroupWidget.tcl]]
   [list source [file join $dir library/oo_Inspector2.tcl]]
   [list source [file join $dir library/oo_LayersInspector.tcl]]
   [list source [file join $dir library/oo_PlotInspectorAnalysis.tcl]]
   [list source [file join $dir library/oo_Worldview.tcl]]
   [list source [file join $dir library/oo_PlotInspector.tcl]]
   [list source [file join $dir library/oo_HistogramInspector.tcl]]
   [list source [file join $dir library/oo_HistogramInspectorAnalysis.tcl]]
   [list source [file join $dir library/oo_SerialaxesInspectorAnalysis.tcl]]
   [list source [file join $dir library/oo_LoonInspector.tcl]]
   [list source [file join $dir library/oo_Ladder.tcl]]
   [list source [file join $dir library/oo_Graphswitch.tcl]]
   [list source [file join $dir library/oo_withNavigators.tcl]]
   [list source [file join $dir library/oo_withContexts.tcl]]
   [list source [file join $dir library/oo_Navigator.tcl]]
   [list source [file join $dir library/oo_Graph_Model.tcl]]
   [list source [file join $dir library/oo_Map.tcl]]
   [list source [file join $dir library/oo_PlotMap.tcl]]
   [list source [file join $dir library/oo_WorldviewMap.tcl]]
   [list source [file join $dir library/oo_Plot_View.tcl]]
   [list source [file join $dir library/oo_NonLayered_View.tcl]]
   [list source [file join $dir library/oo_Layered_View.tcl]]
   [list source [file join $dir library/oo_Decorated_View.tcl]]
   [list source [file join $dir library/oo_Scatterplot_View.tcl]]
   [list source [file join $dir library/oo_Worldview_View.tcl]]
   [list source [file join $dir library/oo_Graph_View.tcl]]
   [list source [file join $dir library/oo_Controller.tcl]]
   [list source [file join $dir library/oo_Canvas_Controller.tcl]]
   [list source [file join $dir library/oo_Resize_Controller.tcl]]
   [list source [file join $dir library/oo_ZoomPan_Controller.tcl]]
   [list source [file join $dir library/oo_ButtonPressMotion_Controller.tcl]]
   [list source [file join $dir library/oo_ItemLabel_Controller.tcl]]
   [list source [file join $dir library/oo_SweepBrush_Controller.tcl]]
   [list source [file join $dir library/oo_TempMove_Controller.tcl]]
   [list source [file join $dir library/oo_Scatterplot_Controller.tcl]]
   [list source [file join $dir library/oo_Worldview_Controller.tcl]]
   [list source [file join $dir library/oo_Graph_Controller.tcl]]
   [list source [file join $dir library/oo_Serialaxes_Controller.tcl]]
   [list source [file join $dir library/oo_Widget.tcl]]
   [list source [file join $dir library/oo_Plot_Widget.tcl]]
   [list source [file join $dir library/oo_Scatterplot_Widget.tcl]]
   [list source [file join $dir library/oo_Graph_Widget.tcl]]
   [list source [file join $dir library/oo_Serialaxes.tcl]]
   [list source [file join $dir library/oo_Serialaxes_Model.tcl]]
   [list source [file join $dir library/oo_Serialaxes_View.tcl]]
   [list source [file join $dir library/oo_SerialaxesAbstractVisual.tcl]]
   [list source [file join $dir library/oo_StarglyphsStackedVisual.tcl]]
   [list source [file join $dir library/oo_ParallelCoordinatesVisual.tcl]]
   [list source [file join $dir library/oo_Glyph.tcl]]
   [list source [file join $dir library/oo_TextGlyph.tcl]]
   [list source [file join $dir library/oo_ImageGlyph.tcl]]
   [list source [file join $dir library/oo_SerialaxesGlyph.tcl]]
   [list source [file join $dir library/oo_SpiroGlyph.tcl]]
   [list source [file join $dir library/oo_PolygonGlyph.tcl]]
   [list source [file join $dir library/oo_PointrangeGlyph.tcl]]
   [list source [file join $dir library/oo_GlyphInspector.tcl]]
   [list source [file join $dir library/oo_SerialaxesGlyphInspector.tcl]]
   [list source [file join $dir library/oo_SpiroGlyphInspector.tcl]]
   [list source [file join $dir library/oo_PolygonGlyphInspector.tcl]]
   [list source [file join $dir library/oo_PointrangeGlyphInspector.tcl]]
   [list source [file join $dir library/oo_ImageGlyphInspector.tcl]]
   [list source [file join $dir library/oo_TextGlyphInspector.tcl]]
   [list source [file join $dir library/oo_GlyphsInspector.tcl]]
   [list source [file join $dir library/oo_NavigatorsInspector.tcl]]
   [list source [file join $dir library/oo_NavigatorInspector.tcl]]
   [list source [file join $dir library/oo_withData.tcl]]
   [list source [file join $dir library/oo_withScaledData.tcl]]
   [list source [file join $dir library/oo_Context.tcl]]
   [list source [file join $dir library/oo_Context2d.tcl]]
   [list source [file join $dir library/oo_Geodesic2d.tcl]]
   [list source [file join $dir library/oo_Slicing2d.tcl]]
   [list source [file join $dir library/oo_Histogram_Model.tcl]]
   [list source [file join $dir library/oo_Histogram_View.tcl]]
   [list source [file join $dir library/oo_Histogram_Widget.tcl]]
   [list source [file join $dir library/oo_Histogram_Controller.tcl]]
   [list source [file join $dir library/oo_HistogramVisual.tcl]]
   [list source [file join $dir library/oo_HistogramWorldviewVisual.tcl]]
   [list source [file join $dir library/oo_HistogramLayer.tcl]]
   [list source [file join $dir library/oo_ColorCrossTable.tcl]]
   [list source [file join $dir library/setMetaKeys.tcl]]
   [list source [file join $dir library/x_LoonInspector.tcl]]
   [list source [file join $dir library/applySelectionLogic.tcl]]
   [list source [file join $dir library/x_baloonHelp.tcl]]
   [list source [file join $dir library/x_context.tcl]]
   [list source [file join $dir library/x_resize.tcl]]
   [list source [file join $dir library/oo_ConditioningScale.tcl]]
   [list source [file join $dir library/toplevel.tcl]]
   [list source [file join $dir library/x_synchronize.tcl]]
   [list source [file join $dir library/data.tcl]]
   [list source [file join $dir library/image_scale.tcl]]
   [list source [file join $dir library/loon_dialog.tcl]]
   [list source [file join $dir library/x_WidgetFactory.tcl]]
   [list source [file join $dir library/oo_GraphInspectorAnalysis.tcl]]
   [list source [file join $dir library/oo_TextsWorldviewVisual.tcl]]
   [list source [file join $dir library/callstack.tcl]]
   [list source [file join $dir library/x_map.tcl]]
   [list source [file join $dir library/util-color.tcl]]
   [list source [file join $dir library/oo_GraphInspectorEdgesAnalysis.tcl]]
   [list source [file join $dir library/scales_extended.tcl]]
   [list source [file join $dir library/x_widgets.tcl]]
   [list source [file join $dir library/oo_GraphInspector.tcl]]
   [list source [file join $dir library/export.tcl]]
   [list source [file join $dir library/navgraph.tcl]]
   [list source [file join $dir library/oo_GraphInspectorNodesAnalysis.tcl]]
   [list source [file join $dir library/oo_MinMaxScale.tcl]]
   [list source [file join $dir library/imageviewer.tcl]]
   [list source [file join $dir library/oo_Serialaxes_Widget.tcl]]
   [list source [file join $dir library/x_graphutils.tcl]]
   [list source [file join $dir library/eventsutil.tcl]]
   [list source [file join $dir library/oo_TextWorldviewVisual.tcl]]
"
