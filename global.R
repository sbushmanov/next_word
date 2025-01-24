library("compiler")
library(data.table)
library(shiny)
library(markdown)
# load data
load("./data/bModel.RData")
load("./data/tModel.RData")
load("./data/vocab.RData")
setkey(bModel, Key)
setkey(tModel, Key)
setkey(vocab, tok)
# clean function for normalizing input
.strip2 <- function(x) {
        y <- gsub("’", "'", x)
        y <- iconv(y, "latin1", "ASCII", sub=" ")
        y <- gsub("D;|:o)|:c)|:D|:>|:-)|:)|;)", " ", y)
        y <- gsub("^RT\\s?(\\s:\\s)?", " ", y)
        y <- gsub(";\\s|:\\s|\\s-+\\s", " ", y)
        y <- gsub("[^a-zA-Z0-9\\.\\?!'-]", " ", y)
        y <- gsub("\\s*!+", " ", y)
        y <- gsub("\\s*\\?+", " ", y)
        y <- gsub("\\.{2,}", " ", y)
        y <- gsub("-+", "-", y)
        y <- gsub("(\\s+\\.\\s+)", " ", y)
        y <- gsub("(\\.\\s\\.)|(-\\s-)|(\\s+$)|(^\\s+)|(^\\.\\s)|(\\s'\\s)", "", y)
        y <- gsub("\\s+", " ", y)
        y <- tolower(y)
        y <- unlist(strsplit(y, " "))
        l <- length(y)
        return(c(y[l-1], y[l]))
}
# compile .strip2 function to speed up app
.strip2 <- cmpfun(.strip2)
