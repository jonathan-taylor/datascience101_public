#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

if(length(args) != 2) {
    cat("Expecting two arguments: full_path_to_git_repo full_path_to_stats101_package", "\n")
    stop("Example: make_pkg_list.R ~/Bitbucket/datascience_101 ~/Bitbucket/stats101", "\n")
}

bitbucket <- args[1]
stats101 <- args[2]
module_dir <- "modules"

cran_req <- "R-requirements.txt"
github_req <- "R-github.txt"
bioc_req <- "BioC-requirements.txt"

modules <- list.files(path = sprintf("%s/%s", bitbucket, module_dir), full.names = TRUE)

cran_list <- github_list <- bioc_list <- character(0)

for (m in modules) {
    cran_reqs <- sprintf("%s/%s", m, cran_req)
    if (file.exists(cran_reqs)) {
        cran_list <- c(cran_list, readLines(cran_reqs))
    }
    github_reqs <- sprintf("%s/%s", m, github_req)
    if (file.exists(github_reqs)) {
        github_list <- c(github_list, readLines(github_reqs))
    }
    bioc_reqs <- sprintf("%s/%s", m, bioc_req)
    if (file.exists(bioc_reqs)) {
        bioc_list <- c(bioc_list, readLines(bioc_reqs))
    }


}

writeLines(sort(unique(cran_list)), con = sprintf("%s/inst/extdata/cran-pkgs.txt", stats101))
writeLines(sort(unique(github_list)), con = sprintf("%s/inst/extdata/github-pkgs.txt", stats101))
writeLines(sort(unique(bioc_list)), con = sprintf("%s/inst/extdata/bioc-pkgs.txt", stats101))



