% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/configuration.R
\name{configuration}
\alias{configuration}
\title{Character Configuration}
\usage{
configuration(mtext, by = c("Act", "Scene"), mode = c("Active", "Passive"),
  onlyPresence = FALSE, useCharacterId = FALSE, asList = TRUE)
}
\arguments{
\item{mtext}{The text including Act and Scene markings}

\item{by}{A string, either "Act" or "Scene". Partial matching allowed.}

\item{mode}{Character vector, should be either "Active" or "Passive".
Passive configurations express when characters are mentioned, active
ones when they speak themselves.}

\item{onlyPresence}{If TRUE, the resulting matrix only contains 
logical values for stage presence}

\item{useCharacterId}{Logical. If true, characters are represented 
by their id instead of their surface form.}

\item{asList}{Logical, defaults to TRUE. Whether to return as a list 
instead of a data frame.}
}
\description{
Creates classic drama configuration matrix. Returns either a list with 
the three components matrix, drama, and figure, or a data.frame containing everything.
}
\section{Active and Passive Configurations}{

By default, we generate active matrices that are based on 
the character speech. A character is present in a scene or 
act, if they make an utterance. 
Using the argument \code{mode}, we can also create passive
configuration matrices. They look very similar, but are based
on who's mentioned in a scene or an act.
}

\examples{
# Active configuration matrix
data(rksp.0)
cfg <- configuration(rksp.0$mtext, asList=FALSE)
# Passive configuration matrix
cfg <- configuration(rksp.0$mtext, asList=FALSE, mode="Passive")

}
