\name{rrfc5}
\alias{rrfc5}
\title{Roughenen Random Forests - C5 (RRFC5)}
\usage{
rrfc5(dat, yvar = ncol(dat), tr, te, mispct, number.trees)
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
RRFC5 algorithm

1.Impose missing values under the mechanism of missing completely at random on all covariates of the training dataset.

2.Regression-based imputation for all variables. Linear regression is used to impute continuous variables. Logistic regression is used to impute binary variables. And multinomial logistic regression is used to impute categorical 
variables with three or more categories.

3.Build one tree in random forests using the above imputed training dataset, and then use it to predict the binary 
outcomes in the original testing dataset.

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
\code{\link{rrfa}}, \code{\link{rrfb}}, \code{\link{rrfc1}}, \code{\link{rrfc2}}, \code{\link{rrfc3}}, \code{\link{rrfc4}}, \code{\link{rrfc6}}, \code{\link{rrfc7}}, \code{\link{rrfd}}, \code{\link{rrfe}}
}

\examples{
if(require(MASS)){
if(require(caTools)){

dat=rbind(Pima.tr,Pima.te)
number.trees=50
#number.trees=500
tr=1:200
te=201:532
mispct=0.1
yvar=ncol(dat)
  
#AUC value for the testing dataset based on the original random forests
rf=randomForest(dat[tr,-yvar],dat[tr,yvar],dat[te,-yvar],ntree=number.trees)
print(colAUC(rf$test$votes[,2],dat[te,yvar]))

#AUC value for the testing dataset based on RRFC5
pred.rrfc5=rrfc5(dat,yvar,tr,te,mispct,number.trees)
print(colAUC(apply(pred.rrfc5$pred,1,mean),dat[te,yvar]))
}}
#
}

