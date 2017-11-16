PdRet <- function(index, period){
   
   library(magrittr)
   load('R:/David/Projects/Economic & Market Summary/Data/dat.RData')
   
   foo <- dat$index.returns[[index, period]] %>%
            format(digits = 2) %>%
            paste0('%')

   return(foo)
}