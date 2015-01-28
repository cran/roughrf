\name{rrfe}
\alias{rrfe}
\title{Roughenen Random Forests - E (RRFE)}
\usage{
rrfe(dat, yvar = ncol(dat), tr, te, mispct, number.trees, k)
}
\arguments{
\item{dat}{A data frame containing both training and testing datasets}

\item{yvar}{The column number of the binary outcome variable, a factor variable. The default value is set as ncol(dat)}

\item{tr}{Row numbers of all training data}

\item{te}{Row numbers of all testing data}

\item{mispct}{Rate of missing data, ranging from 0 to 1}

\item{number.trees}{Number of trees used in roughened random forests}

\item{k}{The k-th power of a variable's relative importance is used for deciding the probability of imposing missing data on this variable}
}
\value{
A prediction matrix. Each column shows the predicted values by a single tree. Each row is sequentially associated with the observations in the testing dataset. Each cell value is either 0 or 1.
}
\description{
RRFE algorithm

1.Impose missing values under the mechanism of missing completely at random on selected covariates of the training 
dataset, and the probability that missing data is imposed on a certain variable is based on the \code{k} -th power of 
its relative importance. The relative importance of a variable is defined as its variable importance divided by the 
maximum variable importance among all available covariates according to the original random forests. Here, the variable importance is based on the mean decrease in node impurity.

2.Impute the missing data by median imputation for continuous variables and mode imputation for categorical variables.

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
\code{\link{rrfa}}, \code{\link{rrfb}}, \code{\link{rrfc1}}, \code{\link{rrfc2}}, \code{\link{rrfc3}}, \code{\link{rrfc4}}, \code{\link{rrfc5}}, \code{\link{rrfc6}}, \code{\link{rrfc7}}, \code{\link{rrfd}}
}

\examples{
if(require(MASS)){
if(require(caTools)){
 
dat=rbind(Pima.tr,Pima.te)
number.trees=50
#number.trees=500
tr=1:200
te=201:532
mispct=0.5
yvar=ncol(dat)
k=2
  
#AUC value for the testing dataset based on the original random forests
rf=randomForest(dat[tr,-yvar],dat[tr,yvar],dat[te,-yvar],ntree=number.trees)
print(colAUC(rf$test$votes[,2],dat[te,yvar]))

#AUC value for the testing dataset based on RRFE
pred.rrfe=rrfe(dat,yvar,tr,te,mispct,number.trees,k)
print(colAUC(apply(pred.rrfe$pred,1,mean),dat[te,yvar]))
}}
#
}

