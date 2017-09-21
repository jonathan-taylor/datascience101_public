#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

lines <- readLines(args[1])
lines <- gsub('-OPEN_NEWTAB"', '" target="_blank"', lines)
writeLines(lines, con = args[1])
