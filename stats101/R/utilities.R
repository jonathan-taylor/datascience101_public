catn <- function(...) cat(..., "\n")

#' Install packages or packages from a CRAN repository if not already installed
#'
#' @description Install a package or packages if it is not already
#'     installed. By default, the repository used is the cloud
#'     repository. This has no effect if the packages are already
#'     installed and is, therefore, a safe way to ensure necessary
#'     packages are available to be used in subsequent code. So in two
#'     invocations of this function with the same arguments, only the
#'     first may have an effect. See examples.
#'
#' @param packages a character vector (one or more) of packages to
#'     install. Dependencies will be installed as well.
#' @param ... other args passed to \code{\link{install.packages}}
#'
#' @export
#'
#' @importFrom utils install.packages installed.packages
#'
#' @examples
#' \dontrun{
#' installIfNeeded("survival")  ## has no effect
#' installIfNeeded("dplyr") ## will install the dependencies as well if not installed.
#' }
#'
installIfNeeded <- function(packages, ...) {
    toInstall <- setdiff(packages, utils::installed.packages()[, 1])
    if (length(toInstall) > 0) {
        utils::install.packages(pkgs = toInstall,
                                repos = "https://cloud.r-project.org",
                                ...)
    }
}


#' stats101_setup
#'
#' @description Set up the R environment by installing all required
#'     packages for the course. CRAN packages are installed as binary,
#'     even if a newer source package is available. Github packages
#'     are installed from source, but they better not assume
#'     availability of developer tools on the target machine.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' installIfNeeded("survival")  ## has no effect
#' installIfNeeded("dplyr") ## will install the dependencies as well if not installed.
#' }
stats101_setup <- function() {
    install.packages("remotes", repos = "https://cloud.r-project.org")
    installed <- utils::installed.packages()[, 1]

    catn("Onetime install of CRAN packages if not already installed (step 1 of 3)")
    catn("May take some time...")
    cran_list <- readLines(system.file("extdata", "cran-pkgs.txt", package = "stats101"))
    toInstall <- setdiff(cran_list, installed)
    if (length(toInstall) > 0) {
        utils::install.packages(pkgs = toInstall,
                                repos = "https://cloud.r-project.org",
                                type = "binary")
    }
    catn("Step 1 done.")

    catn("Onetime install of Bioconductor packages if not already installed (step 2 of 3)")
    catn("May take some time...")

    bioc_list <- readLines(system.file("extdata", "bioc-pkgs.txt", package = "stats101"))
    toInstall <- setdiff(bioc_list, installed)
    if (length(toInstall) > 0) {
        source("https://bioconductor.org/biocLite.R")
        biocLite(toInstall, ask = FALSE)
    }
    catn("Step 2 done.")

    catn("Onetime install of github packages if not already installed (step 3 of 3)")
    catn("May take some time...")
    github_list <- readLines(system.file("extdata", "github-pkgs.txt", package = "stats101"))
    github_packs <- sapply(github_list, function(x) unlist(strsplit(x, split = "/"))[2])
    names(github_list) <- github_packs
    toInstall <- setdiff(github_packs, installed)
    if (length(toInstall) > 0) {
        requireNamespace("remotes", quietly = TRUE)
        for (x in github_list[toInstall]) {
            remotes::install_github(x)
        }
    }

    catn("Step 3 Done!")
    invisible(TRUE)
}

