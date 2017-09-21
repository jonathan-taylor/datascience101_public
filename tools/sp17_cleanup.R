#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

modules <- c("intro",
             "data",
             "summaries",
             "visualization",
             "sampling",
             "inference",
             "prediction",
             "principal_components",
             "nonparametric",
             "replicability")

library(stringr)
for (module in modules) {
    allFiles <- list.files(path = sprintf("%s/%s", args[1], module),
                           recursive = FALSE, full.names = TRUE)
    toKeep <- c(grep(pattern = "lecture[0-9][0-9]\\.html$", x = allFiles, value = TRUE),
                grep(pattern = "lecture[0-9][0-9]\\.pdf$", x = allFiles, value = TRUE))
    toDelete <- setdiff(allFiles, toKeep)
    for (item in toDelete) {
        unlink(item, recursive = TRUE)
    }
}

