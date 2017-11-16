######################################################################
######################################################################

# Downloads data for Economic & Market Summary document

######################################################################
######################################################################

# Connect to Bloomberg API
library(Rblpapi)
blpConnect()

setwd('R:/David/Projects/Economic & Market Summary/Data')

source('indexes.R')
source('periodReturns.R')

dat <- list()

source('getData_indexReturns.R')
source('getData_memberReturns.R')