\name{survConcordance}
\alias{survConcordance}
\alias{survConcordance.fit}
\title{
  Compute a concordance measure.
}
\description{
This function computes the concordance between a right-censored
survival time and a single continuous covariate
}
\usage{
survConcordance(formula, data, weights, subset, na.action)
survConcordance.fit(y, x, strata, weight)
}
\arguments{
\item{formula}{
a formula with a survival time on the left and a single covariate on the
right, along with an optional \code{strata()} term.
The left hand term can also be a numeric vector.
}
\item{data}{
a data frame
}
\item{weights,subset,na.action}{as for \code{coxph}}
\item{x, y, strata, weight}{predictor, response, strata, and weight
  vectors for the direct call}
}
\value{
an object containing the concordance, followed by the
number of pairs that agree, disagree, are tied, and are
not comparable.  
}
\details{
The \code{survConcordance.fit} function computes the result but does
no data checking whatsoever.
It is intended as a hook for other packages that wish to compute
concordance, and the data has already been assembled and verified.
  
Concordance is defined as Pr(agreement) for any two randomly chosen
observations, where in this case agreement means that the observation
with the shorter survival time of the two 
also has the larger risk score.
The predictor (or risk score) will often be the result of
a Cox model or other regression.

For continuous covariates concordance is equivalent to Kendall's tau,
and for logistic regression is is equivalent to the area under the ROC
curve.  A value of 1 signifies perfect agreement, .6-.7 is
a common result for survival data, .5 is an agreement that is no
better than chance, and .3-.4 is the performance of some stock market analysts.

The computation involves all n(n-1)/2 pairs of data points in the
sample.
For survival data, however, some of the pairs are incomparable.  
For instance a pair of times (5+, 8), the first being a censored value.
We do not know whether the first survival time is greater than or less than
the second.
Among observations that are comparable, pairs may also be tied on
survival time (but only if both are uncensored) or on the predictor.
The final concordance is (agree + tied/2)/(agree + disagree + tied).

There is, unfortunately, one aspect of the formula above that is unclear.
Should the count of ties include observations that are tied on survival time y,
tied on the predictor x, or both?
By default the concordance only counts ties in x, treating tied survival
times as incomparable; this agrees with the AUC calculation used in
logistic regression.
The Goodman-Kruskal Gamma statistic is
(agree-disagree)/(agree + disagree), ignoring ties.  It ranges from -1 to 
+1 similar to a correlation coefficient. 
Kendall's tau uses ties of both types.
All of the components are returned
in the result, however, so people can compute other combinations if interested.
(If two observations have the same survival and the same x, they are counted
in the tied survival time category).

The algorithm is based on a balanced binary tree, which allows the computation
to be done in O(n log n) time.
}
\seealso{\code{\link{concordance}}
}
\keyword{survival}
