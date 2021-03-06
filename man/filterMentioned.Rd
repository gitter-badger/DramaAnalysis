% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/text.R
\name{filterMentioned}
\alias{filterMentioned}
\title{Filtering Mentioned Figures}
\usage{
filterMentioned(t, other = FALSE)
}
\arguments{
\item{t}{The text, a data frame listing each token for each figure}

\item{other}{Whether to summarize mentioned figures as 'OTHER'}
}
\description{
This function can be used to remove the mentions of figures 
that do not appear as speakers in the subsetted input text (after using 
limitFigures(), for example), or to summarize them as 'OTHER'.
}
\examples{
data(rksp.0)
text.top10.filtered <- filterMentioned(limitFigures(rksp.0$mtext))
}
