
p = 5;
n = 100;
betas = c(2.1, 3.5, -1.9, 2.0, 1.5);
samples = rnorm(n * (p - 1));
X = matrix(samples, nrow = n, ncol = p-1);
X.with.quadratic = cbind(X, X[, 1]^2);
y = X.with.quadratic %*% betas + .5 * rnorm(n);

par(mfrow=c(2, 2));
plot(X[, 1], y)
plot(X[, 2], y)
plot(X[, 3], y)
plot(X[, 4], y)

linreg = lm(formula = y ~ X);
betas = linreg$coefficients[2:p];
par(mfrow = c(2, 2));
plot(X[, 1], linreg$residuals + X[, 1] * betas[1])
plot(X[, 2], linreg$residuals + X[, 2] * betas[2])
plot(X[, 3], linreg$residuals + X[, 3] * betas[3])
plot(X[, 4], linreg$residuals + X[, 4] * betas[4])

linreg = lm(formula = y ~ X.with.quadratic);
betas = linreg$coefficients[2:p+1];
par(mfrow = c(2, 2));
plot(X[, 1], linreg$residuals + X.with.quadratic[, 1] * betas[1])
plot(X[, 2], linreg$residuals + X[, 2] * betas[2])
plot(X[, 3], linreg$residuals + X[, 3] * betas[3])
plot(X[, 4], linreg$residuals + X[, 4] * betas[4])

par(mfrow = c(1, 1));
qqnorm(linreg$residuals / sd(linreg$residuals));
lines(c(-2, 2), c(-2, 2), col="red", lwd=2);

hist(linreg$residuals, plot=TRUE, breaks=20);
