% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/comments.R
\name{get_comments}
\alias{get_comments}
\title{Retrieve comments}
\usage{
get_comments(repository, issue = NULL)
}
\arguments{
\item{repository}{A character of repository "owner/repo".}

\item{issue}{The number of the issue}
}
\value{
A \code{data.frame}
}
\description{
Tidy comments of a repository
}
\examples{
get_comments("llrs/blogR", 10)
}
