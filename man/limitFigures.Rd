% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/text.R
\name{limitFigures}
\alias{limitFigures}
\title{Filtering figures}
\usage{
limitFigures(text, by = c("rank", "tokens"), threshold = ifelse(by ==
  "tokens", 500, 10), other = FALSE)
}
\arguments{
\item{text}{The dramatic text in table form}

\item{by}{A character vector, either "rank" or "tokens" (or unambigious sub string)}

\item{threshold}{A number specifying the limit}

\item{other}{Whether to summarize filtered figures as 'OTHER' instead of removing their speech}
}
\description{
This function can be used to remove speech content of certain figures. 
Currently, it offers two ways of filtering: By rank or by spoken words. Filtering by 
rank is an upper criterion, i.e., up to $threshold$ figures are included. Filtering 
by tokens is a lower limit: Every figure that speaks more than $threshold$ figures is
included.
}
\examples{
data(rksp.0)
text.top10 <- limitFigures(rksp.0$mtext)
}
