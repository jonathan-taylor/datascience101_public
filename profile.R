## CRAN repository

options(repos = "https://cloud.r-project.org/")

## Loop over this for each required package

installIfNeeded <- function(packages) {
  for (package in packages) {
      installedPackages = installed.packages()[, 1]
      if (! (package %in% installedPackages)) {
          install.packages(package)
      }
  }
}

## Now look for dev installs

installIfNeeded('devtools')

installDevIfNeeded <- function(packages) {
  for (package in packages) {
      installedPackages = installed.packages()[, 1]
      packagename = strsplit(package, '/')[2]
      if (! (packagename %in% installedPackages)) {
          devtools::install_github(package)
      }
  }
}
