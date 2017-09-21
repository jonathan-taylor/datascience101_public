#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(rmarkdown)
rmarkdown::render(input = args[1], output_format = "html_document")




