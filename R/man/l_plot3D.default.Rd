% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/l_plot3D.R
\name{l_plot3D.default}
\alias{l_plot3D.default}
\title{The default \code{l_plot} method to create 3d interactive scatterplot}
\usage{
\method{l_plot3D}{default}(
  x,
  y = NULL,
  z = NULL,
  axisScaleFactor = 1,
  by = NULL,
  layout = c("grid", "wrap", "separate"),
  connectedScales = c("cross", "row", "column", "both", "x", "y", "none"),
  color = l_getOption("color"),
  glyph = l_getOption("glyph"),
  size = l_getOption("size"),
  active = TRUE,
  selected = FALSE,
  xlabel,
  ylabel,
  zlabel,
  title,
  showLabels = TRUE,
  showScales = FALSE,
  showGuides = TRUE,
  guidelines = l_getOption("guidelines"),
  guidesBackground = l_getOption("guidesBackground"),
  foreground = l_getOption("foreground"),
  background = l_getOption("background"),
  parent = NULL,
  ...
)
}
\arguments{
\item{x}{the x, y and z arguments provide the x, y and z coordinates for the plot.
         Any reasonable way of defining the coordinates is acceptable.
         See the function xyz.coords for details.

         If supplied separately, they must be of the same length.}

\item{y}{the y coordinates of points in the plot,
optional if x is an appropriate structure.}

\item{z}{the z coordinates of points in the plot,
optional if x is an appropriate structure.}

\item{axisScaleFactor}{the amount to scale the axes at the centre of the rotation.
Default is 1.
    All numerical values are acceptable (0 removes the axes, < 0 inverts the direction of
    all axes.)}

\item{by}{loon plot can be separated by some variables into multiple panels.
This argument can take a \code{vector}, a \code{list} of same lengths or a \code{data.frame} as input.}

\item{layout}{layout facets as \code{'grid'}, \code{'wrap'} or \code{'separate'}}

\item{connectedScales}{Determines how the scales of the facets are to be connected depending
on which \code{layout} is used.  For each value of \code{layout}, the scales are connected
as follows:
\itemize{
\item{\code{layout = "wrap":}  Across all facets, when \code{connectedScales} is
   \itemize{
   \item{\code{"x"}, then  only the "x"  scales are connected}
   \item{\code{"y"}, then only the "y" scales are connected}
   \item{\code{"both"},  both "x" and "y" scales are connected}
   \item{\code{"none"},  neither "x" nor "y" scales are connected.}
   For any other value, only the "y" scale is connected.
   }
   }
\item{\code{layout = "grid":}  Across all facets, when \code{connectedScales} is
   \itemize{
   \item{\code{"cross"}, then only the scales in the same row and the same column are connected}
   \item{\code{"row"}, then both "x" and "y" scales of facets in the same row are connected}
   \item{\code{"column"}, then both "x" and "y" scales of facets in the same column are connected}
   \item{\code{"x"}, then all of the "x"  scales are connected (regardless of column)}
   \item{\code{"y"}, then all of the "y" scales are connected (regardless of row)}
   \item{\code{"both"},  both "x" and "y" scales are connected in all facets}
   \item{\code{"none"},  neither "x" nor "y" scales are connected in any facets.}
   }
   }
 }}

\item{color}{colours of points; colours are repeated until matching the number points.
Default is given by \code{\link{l_getOption}("color")}.}

\item{glyph}{shape of point; must be one of the primitive glyphs
             "circle", "ccircle", "ocircle", "square", "csquare", "osquare", "triangle", "ctriangle",
             "otriangle", "diamond", "cdiamond", or "odiamond".

             Prefixes "c" and "o" mean closed and open, respectively.
             Default is given by \code{\link{l_getOption}("glyph")}.

             Non-primitive glyphs such as polygons, images, text, point ranges, and even interactive glyphs like
             serial axes glyphs may be added, but only after the plot has been created.}

\item{size}{size of the symbol (roughly in terms of area).
Default is given by \code{\link{l_getOption}("size")}.}

\item{active}{a logical determining whether points appear or not
(default is \code{TRUE} for all points). If a logical vector is given of length
equal to the number of points, then it identifies which points appear (\code{TRUE})
and which do not (\code{FALSE}).}

\item{selected}{a logical determining whether points appear selected at first
(default is \code{FALSE} for all points). If a logical vector is given of length
equal to the number of points, then it identifies which points are (\code{TRUE})
and which are not (\code{FALSE}).}

\item{xlabel}{Label for the horizontal (x) axis. If missing,
one will be inferred from \code{x} if possible.}

\item{ylabel}{Label for the vertical (y) axis. If missing,
one will be inferred from \code{y} (or \code{x}) if possible.}

\item{zlabel}{Label for the third (perpendicular to the screen) (z) axis. If missing,
one will be inferred from \code{z} (or \code{x}) if possible.}

\item{title}{Title for the plot, default is an empty string.}

\item{showLabels}{logical to determine whether axes label (and title) should be presented.}

\item{showScales}{logical to determine whether numerical scales should
be presented on both axes.}

\item{showGuides}{logical to determine whether to present background guidelines
to help determine locations.}

\item{guidelines}{colour of the guidelines shown when \code{showGuides = TRUE}.
Default is given by \code{\link{l_getOption}("guidelines")}.}

\item{guidesBackground}{colour of the background to the guidelines shown when
          \code{showGuides = TRUE}.
Default is given by \code{\link{l_getOption}("guidesBackground")}.}

\item{foreground}{foreground colour used by all other drawing.
Default is given by \code{\link{l_getOption}("foreground")}.}

\item{background}{background colour used for the plot.
Default is given by \code{\link{l_getOption}("background")}.}

\item{parent}{a valid Tk parent widget path. When the parent widget is
specified (i.e. not \code{NULL}) then the plot widget needs to be placed using
some geometry manager like \code{\link{tkpack}} or \code{\link{tkplace}} in
order to be displayed. See the examples below.}

\item{...}{named arguments to modify plot states.}
}
\description{
Creates an interactive 3d scatterplot. Also, if no loon
  inspector is open then the \code{l_plot3D} call will also open a loon
  inspector.
}
\details{
The scatterplot displays a number of direct interactions with the
  mouse and keyboard, these include: rotating, zooming towards the mouse cursor using
  the mouse wheel, panning by right-click dragging and various selection
  methods using the left mouse button such as sweeping, brushing and
  individual point selection. See the documentation for \code{\link{l_plot3D}}
  for more details about the interaction gestures.
}
\examples{
if(interactive()){

# default use as scatterplot

p1 <- with(quakes,
           l_plot3D(long, lat, depth)
           )

p2 <- with(quakes,
           l_plot3D(mag, stations, depth)
           )

# link the two plots p1 and p2
l_configure(p1, linkingGroup = "quakes", sync = "push")
l_configure(p2, linkingGroup = "quakes", sync = "push")

}
}
\seealso{
Other three-dimensional plotting functions: 
\code{\link{l_plot3D}()},
\code{\link{l_scale3D}()}
}
\concept{three-dimensional plotting functions}
