% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/l_graph.R
\name{l_graph.default}
\alias{l_graph.default}
\title{Create a graph display based on node names and from-to edges list}
\usage{
\method{l_graph}{default}(nodes = "", from = "", to = "", parent = NULL, ...)
}
\arguments{
\item{nodes}{vector with nodenames}

\item{from}{vector with node names of the from-to pairs for edges}

\item{to}{vector with node names of the from-to pairs for edges}

\item{parent}{parent widget of graph display}

\item{...}{arguments to modify the graph display state}
}
\value{
graph handle
}
\description{
This default method uses the loongraph display states as
  arguments to create a graph display.
}
\details{
For more information run: \code{l_help("learn_R_display_graph.html#graph")}
}
\seealso{
\code{\link{loongraph}}, \code{\link{l_graph}},
  \code{\link{l_info_states}}, \code{\link{l_graph.graph}}
}
