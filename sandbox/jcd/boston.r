#####      Boston Housing fun      #####
##
## Some scratch code to read zip data and do some predictions with it

library(MASS);
data(Boston);
boston = Boston;
## Remove the $500,000 sale price, as it is fake
boston = boston[boston$medv != 50, ];

## Plot four of the individual predictors against price
par(mfrow = c(2, 2));
plot(boston$rm, boston$medv, xlab = "Number of rooms",
     ylab = "Sale price", pch=19, cex=.15);
plot(boston$chas, boston$medv, xlab = "Near Charles?",
     ylab = "Sale price", pch=19, cex=.15);
plot(boston$ptratio, boston$medv, xlab = "Student/teacher ratio",
     ylab = "Sale price", pch=19, cex=.15);
plot(boston$zn, boston$medv, xlab = "Large lot proportion",
     ylab = "Sale price", pch=19, cex=.15);


## Now, for each of these, let's run a regression and plot the regression line

# Make a plot of 4 things at once
par(mfrow = c(2, 2));
## Rooms against median sale price
linreg = lm(formula = medv ~ rm, data = boston);
plot(boston$rm, boston$medv, xlab = "Number of rooms",
     ylab = "Sale price", pch=19, cex=.15);
lines(boston$rm, linreg$fitted.values, col="red", lwd = 2);
## Charles distance against median sale price
plot(boston$chas, boston$medv, xlab = "Near Charles?",
     ylab = "Sale price", pch=19, cex=.15);
linreg = lm(formula = medv ~ chas, data = boston);
lines(boston$chas, linreg$fitted.values, col = "red", lwd = 2);
## Pupil/teacher ratio against median sale price
plot(boston$ptratio, boston$medv, xlab = "Student/teacher ratio",
     ylab = "Sale price", pch=19, cex=.15);
linreg = lm(formula = medv ~ ptratio, data = boston);
lines(boston$ptratio, linreg$fitted.values, col = "red", lwd = 2);
## Large lot proportion against median sale price
plot(boston$zn, boston$medv, xlab = "Large lot proportion",
    ylab = "Sale price", pch=19, cex=.15);
linreg = lm(formula = medv ~ zn, data = boston);
lines(boston$zn, linreg$fitted.values, col = "red", lwd = 2);

## Now let us compare single versus multiple regression
par(mfrow = c(1, 2));
reg.rm = lm(formula = medv ~ rm, data = boston);
plot(boston$rm, boston$medv, xlab = "Number of rooms",
     ylab = "Sale price", pch=19, cex=.15,
     main = paste("MSE", round(mean(reg.rm$residuals^2), digits=2)));
lines(boston$rm, reg.rm$fitted.values, col="red", lwd = 2);
reg.ptratio = lm(formula = medv ~ ptratio, data = boston);
plot(boston$ptratio, boston$medv, xlab = "Student/teacher ratio",
     ylab = "Sale price", pch=19, cex=.15,
     main = paste("MSE", round(mean(reg.ptratio$residuals^2), digits=2)));
lines(boston$ptratio, reg.ptratio$fitted.values, col="red", lwd = 2);

reg.rmpt = lm(formula = medv ~ rm + ptratio, data = boston)

par(mfrow = c(1, 2));
rm.hist = hist(reg.rm$residuals, plot=FALSE);
pt.hist = hist(reg.ptratio$residuals, plot=FALSE);
both.hist = hist(reg.rmpt$residuals, plot=FALSE);
plot(pt.hist, col = rgb(0, 0, 1, .25));
plot(both.hist, col = rgb(1, 0, 0, .25), add = TRUE);
plot(rm.hist, col = rgb(0, 0, 1, .25));
plot(both.hist, col = rgb(1, 0, 0, .25), add = TRUE);
# plot(C, col = rgb(1, 0, 0, .25), add = TRUE);

fullregression = lm(formula = medv ~ ., data = boston)

par(mfrow = c(1, 1));
plot(fullregression$fitted.values, boston$medv, type = "p", pch = 4,
     col = rgb(0, 0, 1),
     xlab = "Predicted price", ylab = "Actual price");
points(reg.rm$fitted.values, boston$medv, pch = 2,
       col = rgb(1, .5, .1));


par(mfrow = c(1, 1));
n = length(boston$medv);
plot(1:n, sort(fullregression$residuals^2), lty = 1,
     pch = 4, lwd=2, col="black", log = "y", type = "l",
     xlab = "Data example");
lines(1:n, sort(reg.rm$residuals^2), pch = 15, lwd=2, col="red", lty = 2);
lines(1:n, sort(reg.ptratio$residuals^2), pch = 16, lwd=2, col="blue", lty = 3);

all.hist = hist(fullregression$residuals, plot=FALSE);
rm.hist = hist(reg.rm$residuals, plot=FALSE);
plot(pt.hist, col = rgb(0, 0, 1, .25));
plot(both.hist, col = rgb(1, 0, 0, .25), add = TRUE);

beta = fullregression$coefficients;
beta.j = as.list(beta)$black;
par(mfrow = c(1, 1));
plot(boston$black, fullregression$residuals + beta.j * boston$black);
