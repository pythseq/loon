#' @description Methods to plot map data defined in the \code{\link[sp:00sp]{sp}}
#'   package
#'
#' @param widget widget widget path as a string or as an object handle
#' @param x an object defined in the \code{\link[sp:00sp]{sp}} class
#' @param ... arguments forwarded to the relative \code{\link{l_layer}} function
#'
#' @details Note that currently loon does neither support holes and ring
#'   directions.
#'
#' @references Applied Spatial Data Analysis with R by Bivand, Roger S. and
#'   Pebesma, Edzer and Gomez-Rubio and Virgilio
#'
#'
#' @return layer id
#'
#' @seealso  \code{\link[sp:00sp]{sp}}, \code{\link{l_layer}}
#'
#' @examples
#'
#'if (interactive()) {
#'
#' if (requireNamespace("rworldmap", quietly = TRUE)) {
#'     world <- rworldmap::getMap(resolution = "coarse")
#'     p <- l_plot()
#'     lmap <- l_layer(p, world, asSingleLayer=TRUE)
#'     l_scaleto_world(p)
#'     attr(lmap,'hole')
#'     attr(lmap,'NAME')
#' }
#' }
