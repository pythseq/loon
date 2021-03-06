% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/facet_layout.R
\name{facet_wrap_layout}
\alias{facet_wrap_layout}
\title{Layout as a wrap}
\usage{
facet_wrap_layout(
  plots,
  subtitles,
  prop = 10,
  parent = NULL,
  title = "",
  xlabel = "",
  ylabel = "",
  nrow = NULL,
  ncol = NULL,
  labelLocation = "top",
  byrow = TRUE,
  swapAxes = FALSE,
  labelBackground = "gray80",
  labelForeground = "black",
  labelBorderwidth = 2,
  labelRelief = "groove",
  sep = "*",
  maxCharInOneRow = 15,
  ...
)
}
\arguments{
\item{plots}{A list of \code{loon} plots}

\item{subtitles}{The subtitles of the layout. It is a list and the length is equal to
the number of \code{by} variables. Each element in a list is the unique values of such \code{by} variable.}

\item{prop}{The proportion of the label height and widget height}

\item{parent}{a valid Tk parent widget path. When the parent widget is
specified (i.e. not \code{NULL}) then the plot widget needs to be placed using
some geometry manager like \code{\link{tkpack}} or \code{\link{tkplace}} in
order to be displayed. See the examples below.}

\item{title}{The title of the widget}

\item{xlabel}{The xlabel of the widget}

\item{ylabel}{The ylabel of the widget}

\item{nrow}{The number of layout rows}

\item{ncol}{The number of layout columns}

\item{labelLocation}{Labels location.
\itemize{
\item {
Length two vector for layout \code{grid}.
The first one is used to determine the position of column labels ('top' or 'bottom').
The second one is used to determine the position of row labels ('right' or 'left').
}
\item {
Length one vector for layout \code{wrap}, 'top' or 'bottom'.
}
}}

\item{byrow}{Place widget by row or by column}

\item{swapAxes}{swap axes, \code{TRUE} or \code{FALSE}}

\item{labelBackground}{Label background color}

\item{labelForeground}{Label foreground color}

\item{labelBorderwidth}{Label border width}

\item{labelRelief}{Label relief}

\item{sep}{The character string to separate or combine a vector}

\item{maxCharInOneRow}{Max char in one row. If it exceeds the max, then a char will be displayed into two rows}

\item{...}{named arguments to modify plot states.
See \code{\link{l_info_states}} of any instantiated l_plot for examples of names and values.}
}
\description{
Layout as a wrap
}
