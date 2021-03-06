% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/text.R
\name{limitFiguresByRank}
\alias{limitFiguresByRank}
\title{This method removes the spoken tokens of all but the most frequent n figures}
\usage{
limitFiguresByRank(t, maxRank = 10, other = FALSE)
}
\arguments{
\item{t}{The text, a data frame listing each token for each figure}

\item{maxRank}{Up to maxRank figures remain in the data set}

\item{other}{Whether to summarize filtered figures as 'OTHER' instead of removing their speech}
}
\description{
This method removes the spoken tokens of all but the most frequent n figures
}
\keyword{internal}
