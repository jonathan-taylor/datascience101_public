## Installing Packages

# Just like you have to install apps separately on your phone, to get the most out of R you need 
# to install packages based on your research interests. This can be done one of two ways in RStudio. 
# On the right hand side, click "Packages" (towards the middle) and then "Install". 
# Simply type in the name of the package. Here's how to do it with an R command:

install.packages("fivethirtyeight", repos="http://cloud.r-project.org")

# (That package contains data featured in 538, the online magazine.)

# You may have to choose a server the first time. It doesn't matter much but I usually find something relatively local.

## RTools for Windows

# Many of the newer packages and development features in R require Windows users to have RTools. 

### Getting RTools for Windows 
# Windows users should install RTools 3.3 from  
# https://cran.r-project.org/bin/windows/Rtools/


## Installing the Data Science 101 Packages
# To be able to do all of the lab activies and work with the code found in lecture slides, 
# you need a long list of packages. 
# Fortunately, this can all be done at once. 

pkgs <- read.table('https://www.stanford.edu/class/stats101/R-requirements.txt', header=FALSE)$V1
packages_needed = setdiff(pkgs, installed.packages()[,'Package'])

# normally you could just do install.packages(pkgs)
# however, that's a little unstable with such a long list
# since you don't want any package to be open that may be affected
# by the install. instead, we will use a short loop that does them
# one at a time.

for(pkg in packages_needed){
  install.packages(pkg, repos='http://cloud.r-project.org')
}


## Installing from GitHub

# Packages under development are often only available on GitHub. 
# These are installed by opening the devtools (as in development tools) library. 
# Here's how to install the two we will use:


library(devtools)
pkgs <- read.table('https://www.stanford.edu/class/stats101/R-github.txt', header=FALSE)$V1

for(pkg in pkgs){
    install_github(pkg)
}