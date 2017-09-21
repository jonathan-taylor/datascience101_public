#####      Zip Code decoding      #####
##
## Some scratch code to read zip data and do some predictions with it

ones <- function(nr, nc = 1) {
    return(matrix(1, nrow = nr, ncol = nc));
}
zeros <- function(nr, nc = 1) {
    return(matrix(0, nrow = nr, ncol = nc));
}

## DATA PROCESSING

constructData <- function(pc = 4, nc = 9) {
  ziptrain <- as.matrix(read.csv(file="~/Data/ZIP/zip.train",head=FALSE, sep=" "));
  ziptest <- as.matrix(read.csv(file="~/Data/ZIP/zip.test",head=FALSE,sep=" "));
  Xtrain = ziptrain[, c(2:257)];
  Xtest = ziptest[, c(2:257)];
  ytrain = as.vector(ziptrain[, 1]);
  ytest = as.vector(ziptest[, 1]);

  trainfileX = paste(pc, nc, "_train_images.csv", sep="");
  testfileX = paste(pc, nc, "_test_images.csv", sep="");
  trainfileY = paste(pc, nc, "_train_labels.csv", sep="");
  testfileY = paste(pc, nc, "_test_labels.csv", sep="");
  train_inds = (ytrain == pc | ytrain == nc);
  test_inds = (ytest == pc | ytest == nc);
  ytrain = ytrain[train_inds];
  ytrain[ytrain == nc] = -1;
  ytrain[ytrain == pc] = 1;
  ytest = ytest[test_inds];
  ytest[ytest == nc] = -1;
  ytest[ytest == pc] = 1;
  Xtrain = Xtrain[train_inds,];
  Xtest = Xtest[test_inds,];
  ntrain = nrow(Xtrain);
  dim = ncol(Xtrain);
  ## Add a tiny bit of noise to the training data, as it is low rank otherwise.
  Xtrain = Xtrain + matrix(rnorm(dim * ntrain, sd=.01), nrow=ntrain, ncol=dim);
  Xtrain = pmax(pmin(Xtrain, 1), -1);

  write.table(Xtrain, file = trainfileX, row.names=FALSE, col.names=FALSE);
  write.table(Xtest, file = testfileX, row.names=FALSE, col.names=FALSE);
  write.table(ytrain, file = trainfileY, row.names=FALSE, col.names=FALSE);
  write.table(ytest, file = testfileY, row.names=FALSE, col.names=FALSE);
}

loadZips <- function(pc = 4, nc = 9, base = "~/ds101/sandbox/jcd/") {
  X.trainfile = paste(base, pc, nc, "_train_images.csv", sep="");
  X.testfile = paste(base, pc, nc, "_test_images.csv", sep="");
  y.trainfile = paste(base, pc, nc, "_train_labels.csv", sep="");
  y.testfile = paste(base, pc, nc, "_test_labels.csv", sep="");
  Xtrain = as.matrix(read.table(X.trainfile));
  ytrain = as.vector(as.matrix(read.table(y.trainfile)));
  Xtest = as.matrix(read.table(X.testfile));
  ytest = as.vector(as.matrix(read.table(y.testfile)));
  return(list(Xtrain = Xtrain, ytrain = ytrain, Xtest = Xtest, ytest = ytest));
}

displayImage <- function(x = zeros(16, 16),
                         label = -1) {
    x = matrix(x, nrow = 16, byrow=TRUE);
    image(t(x[16:1,]), col=gray(0:256 / 256),
          asp=1,
          main = paste("True label ", label));
}

################################################################################

D = loadZips(4, 9, "~/ds101/modules/prediction/data/");
Xtest = D$Xtest;
ytest = D$ytest;
Xtrain = D$Xtrain;
ytrain = D$ytrain;

### AFTER THE DATA HAS BEEN SAVED ###

numeric.test.labels = ytest;
numeric.test.labels[numeric.test.labels == 1] = 4;
numeric.test.labels[numeric.test.labels == -1] = 9;
numeric.train.labels = ytrain;
numeric.train.labels[numeric.train.labels == 1] = 4;
numeric.train.labels[numeric.train.labels == -1] = 9;

par(fig = c(0, .5, 0, 1), new = TRUE);
displayImage(Xtrain[1, ], numeric.train.labels[1]);
par(fig = c(.5, 1, 0, 1), new = TRUE);
displayImage(Xtrain[11, ], numeric.train.labels[11]);

## Fit the data, make predictions
linreg.fit <- lm(formula = ytrain ~ Xtrain)
train.pred = linreg.fit$fitted.values;
sum(sign(train.pred) != ytrain) / length(ytrain)

beta.0 = linreg.fit$coefficients[1];
beta = linreg.fit$coefficients[2:length(linreg.fit$coefficients)];
test.pred = Xtest %*% beta + beta.0;

## Now, let's find a few example mistakes
mistakes = which(sign(test.pred) != ytest);

par(mfrow = c(1, 2));
## Show some of the mistaken images
displayImage(Xtest[mistakes[5], ], numeric.test.labels[mistakes[5]]);
displayImage(Xtest[mistakes[9], ], numeric.test.labels[mistakes[9]]);

displayImage(Xtest[mistakes[5], ], numeric.test.labels[mistakes[5]]);


###############################################################################

## K-nearest neighbor classification

library(class);
test.predictions = knn(train = Xtrain, test = Xtest, cl = ytrain, k = 1);
num.errors = sum(ytest != test.predictions)
cat(paste("Fraction of mistakes: ",
          round(num.errors / length(test.predictions), digits = 3), "\n"));

test.predictions = knn(train = Xtrain, test = Xtest, cl = ytrain, k = 2);
num.errors = sum(ytest != test.predictions)
cat(paste("Fraction of mistakes for 2 neighbors: ",
          round(num.errors / length(test.predictions), digits = 3), "\n"));
test.predictions = knn(train = Xtrain, test = Xtest, cl = ytrain, k = 3);
num.errors = sum(ytest != test.predictions)
cat(paste("Fraction of mistakes for 3 neighbors: ",
          round(num.errors / length(test.predictions), digits = 3), "\n"));
test.predictions = knn(train = Xtrain, test = Xtest, cl = ytrain, k = 4);
num.errors = sum(ytest != test.predictions)
cat(paste("Fraction of mistakes for 4 neighbors: ",
          round(num.errors / length(test.predictions), digits = 3), "\n"));

mistakes = which(test.predictions != ytest);
x = Xtest[mistakes[1], ];
distances.squared = rowSums((Xtrain - ones(nrow(Xtrain), 1) %*% x)^2);
closest.ind = which.min(distances.squared);
nearest.x = Xtrain[closest.ind, ];

par(mfrow = c(1, 2));
displayImage(x, label = numeric.test.labels[mistakes[1]]);
displayImage(nearest.x, label = numeric.train.labels[mistakes[1]]);


## Time to get the errors for the 3 nearest neighbors nailed down
test.predictions = knn(train = Xtrain, test = Xtest, cl = ytrain, k = 3);
mistakes = which(test.predictions != ytest);
x = Xtest[mistakes[1], ];
distances.squared = rowSums((Xtrain - ones(nrow(Xtrain), 1) %*% x)^2);
distance.ranks = rank(distances.squared);
near.inds = which(distance.ranks <= 3);

par(mfrow = c(2, 2));
displayImage(x, numeric.test.labels[mistakes[1]]);
displayImage(Xtrain[near.inds[1], ], numeric.train.labels[near.inds[1]]);
displayImage(Xtrain[near.inds[2], ], numeric.train.labels[near.inds[2]]);
displayImage(Xtrain[near.inds[3], ], numeric.train.labels[near.inds[3]]);

################################################################################

Xtrain.powers = cbind(Xtrain, Xtrain * Xtrain, Xtrain * Xtrain * Xtrain);
Xtest.powers = cbind(Xtest, Xtest * Xtest, Xtest * Xtest * Xtest);
linreg = lm(ytrain ~ Xtrain.powers);

## Errors in training
cat(paste("Training data: ", sum(sign(linreg$fitted.values) != ytrain),
          " mistakes of ", length(ytrain), " data points\n", sep = ""));
beta.0 = linreg$coefficients[1];
beta = linreg$coefficients[2:length(linreg$coefficients)];
test.pred = Xtest.powers %*% beta + beta.0;
## Now, let's find a few example mistakes
mistakes = which(sign(test.pred) != ytest);
cat(paste("Test data: ", length(mistakes),
          " mistakes of ", length(ytest), " data points (",
          round(100 * length(mistakes) / length(ytest), digits = 1),
          "% error)\n", sep = ""));
