####    HEIGHTS    ##
##
## Some fun code for playing around with height data, plotting residuals, etc.


#####  Code to modify the heights so that they look a little more Gaussian #####
library(psych);
data(galton);
noise.to.add = .5;
child.heights = as.matrix(galton$child) +
    noise.to.add * rnorm(length(galton$parent));
parent.heights = as.matrix(galton$parent) +
    noise.to.add * rnorm(length(galton$parent));
## Make it so the variance is 1, which makes plot look nicer
linreg = lm(formula = child.heights ~ parent.heights);
pred.residuals = linreg$residuals / sd(linreg$residuals);
child.heights = linreg$fitted.values + pred.residuals;
X = data.frame(child.heights, parent.heights);
names(X) = c("child", "parent");
write.csv(X, file = "galton.csv", row.names = TRUE);

###### Read the data and regress ######
heights = read.csv("galton.csv", row.names = 1);
plot(heights$parent, heights$child,
     pch = 19, cex = .25, xlab="", ylab="", asp=1);

min.height = min(min(heights$parent), min(heights$child));
max.height = max(max(heights$child), max(heights$parent));
lines(c(min.height, max.height), c(min.height, max.height), col="red",
     type="l", lwd=3, asp=1, main = "", xlab = "", ylab="");

linreg <- lm(formula = heights$child ~ heights$parent);
lines(heights$parent, linreg$fitted.values, col = "blue", lwd=4);
title(xlab = "Parent height", ylab = "Child height");



intercept = linreg$coefficients[1];
slope = linreg$coefficients[2];
heights = seq(from = min.height, to = max.height, length.out = 2);

pred.residuals = child.heights - slope * parent.heights - intercept;
qqnorm(pred.residuals / sd(pred.residuals));

idresiduals = child.heights - parent.heights;
qqnorm(idresiduals / sqrt(var(idresiduals))[1]);

