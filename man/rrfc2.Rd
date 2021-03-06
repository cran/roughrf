\name{rrfc2}
\alias{rrfc2}
\title{Roughenen Random Forests - C2 (RRFC2)}
\usage{
rrfc2(dat, yvar = ncol(dat), tr, te, mispct, number.trees)
}
\arguments{
\item{dat}{A data frame containing both training and testing datasets}

\item{yvar}{The column number of the binary outcome variable, a factor variable. The default value is set as ncol(dat)}

\item{tr}{Row numbers of all training data}

\item{te}{Row numbers of all testing data}

\item{mispct}{Rate of missing data, ranging from 0 to 1}

\item{number.trees}{Number of trees used in roughened random forests}
}
\value{
A prediction matrix. Each column shows the predicted values by a single tree. Each row is sequentially associated with the observations in the testing dataset. Each cell value is either 0 or 1.
}
\description{
RRFC2 algorithm

1.Impose missing values under the mechanism of missing completely at random on all covariates of the training dataset.

2.Impute the missing values in a continuous variable by its minimum value and impute the missing values in a categorical variable by its mode value (Minimum-value /mode imputation).

3.Build one tree in random forests using the above imputed training dataset, and then use it to predict the binary outcomes in the original testing dataset.

4.Repeat 1 to 3 for \code{number.trees} times. 
}
\author{
Kuangnan Xiong
}

\references{
Breiman, L. (2001). Random forests. Machine learning, 45(1), 5-32.

Liaw, A. & Wiener, M., 2002. Classification and regression by randomForest. R News, 2(3), pp. 18-22.

Xiong, Kuangnan. "Roughened Random Forests for Binary Classification." PhD diss., State University of New York at Albany, 2014.
}

\seealso{
\code{\link{rrfa}}, \code{\link{rrfb}}, \code{\link{rrfc1}},\code{\link{rrfc3}}, \code{\link{rrfc4}}, \code{\link{rrfc5}}, \code{\link{rrfc6}}, \code{\link{rrfc7}}, \code{\link{rrfd}}, \code{\link{rrfe}}
}


\examples{
if(require(MASS)){
if(require(caTools)){

dat=rbind(Pima.tr,Pima.te)
number.trees=50
#number.trees=500
tr=1:200
te=201:532
mispct=0.2
yvar=ncol(dat)
  
#AUC value for the testing dataset based on the original random forests
rf=randomForest(dat[tr,-yvar],dat[tr,yvar],dat[te,-yvar],ntree=number.trees)
print(colAUC(rf$test$votes[,2],dat[te,yvar]))

#AUC value for the testing dataset based on RRFC2
pred.rrfc2=rrfc2(dat,yvar,tr,te,mispct,number.trees)
print(colAUC(apply(pred.rrfc2$pred,1,mean),dat[te,yvar]))

}}


}

