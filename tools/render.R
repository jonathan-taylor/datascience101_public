#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(rmarkdown)
rmarkdown::render(args[1])




