\name{mfix}
\alias{mfix}
\title{Four single imputation methods}
\usage{
mfix(x, mmmm)
}
\arguments{
\item{x}{A dataset with missing values.}

\item{mmmm}{Its value is used to select from four different single imputation methods. \code{mmmm}=1 refers to median/mode imputation; \code{mmmm}=2 refers to mean/mode imputation; \code{mmmm}=3 refers to minimum-value/mode imputation; \code{mmmm}=4 refers to maximum-value/mode imputation.}
}
\value{
Imputed dataset
}
\description{
Four single imputation methods can be implemented by this function, including median/mode imputation (median imputation on continuous variables and mode imputation on categorical variables), mean/mode imputation (mean imputation on continuous variables and mode imputation on categorical variables), minimum-value/mode imputation (minimum-value imputation on continuous variables and mode imputation on categorical variables) and maximum-value/mode imputation (maximum-value imputation on continuous variables and mode imputation on categorical variables). When \code{mmmm}=1, this function is the same as \code{na.roughfix} from R package \code{randomForest}.}
\author{
Kuangnan Xiong
}

\references{
Liaw, A. & Wiener, M., 2002. Classification and regression by randomForest. R News, 2(3), pp. 18-22.
}

\seealso{
\code{\link{rrfa}}, \code{\link{rrfb}}, \code{\link{rrfc1}}, \code{\link{rrfc2}}, \code{\link{rrfc3}}, \code{\link{rrfc4}},\code{\link{rrfc5}}, \code{\link{rrfc6}}, \code{\link{rrfc7}}, \code{\link{rrfd}}, \code{\link{rrfe}}
}

\examples{
dat=data.frame(continuous=c(1,2,3,4,5),categorical=c('a','a','a','a','b'))
dat[2,]=NA
dat
summary(dat)
mfix(dat,1)[2,]  #median/mode imputation
mfix(dat,2)[2,]  #mean/mode imputation
mfix(dat,3)[2,]  #minimum-value/mode imputation
mfix(dat,4)[2,]  #maximum-value/mode imputation
#
}
