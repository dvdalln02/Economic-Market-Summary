######################################################################
######################################################################

# Returns group/member returns of a given index

######################################################################
######################################################################

library(magrittr)
library(stringr)
source('periodReturns.R')

spx.groups <- c('S5INFT',
                'S5HLTH',
                'S5COND',
                'S5INDU',
                'S5CONS',
                'S5ENRS',
                'S5UTIL',
                'S5RLST',
                'S5TELS',
                'S5FINL',
                'S5MATR') %>% paste('Index')

ccmp.groups <- c('IXK',
                 'CIND',
                 'CFIN',
                 'IHC',
                 'CTRN',
                 'CUTL',
                 'CINS',
                 'CBNK') %>% paste('Index')

indu.groups <- bds('INDU Index', 'INDX_MEMBERS')[,1] %>% paste('Equity')

GroupReturns <- function(index){
   if(index == 'SPX Index'){groups  <- spx.groups}
   if(index == 'INDU Index'){groups <- indu.groups}
   if(index == 'CCMP Index'){groups <- ccmp.groups}
   
   group.returns <- bdp(groups, return.periods)
   
   names(group.returns) <- gsub('CHG_PCT_','', names(group.returns))
   
   if(index == 'SPX Index'){
      group.returns$sector <- bdp(row.names(group.returns), 
                                  'LONG_COMP_NAME')[,1] %>%
         gsub('S&P 500 ', '', .) %>%
         gsub(' Sector GICS Level 1 Index', '', .)
      
   }
   
   if(index == 'INDU Index'){
      group.returns$ticker <- bdp(row.names(group.returns),
                                  'TICKER')[,1]
   }
   
   if(index == 'CCMP Index'){
      group.returns$group <- bdp(row.names(group.returns),
                                 'LONG_COMP_NAME')[,1] %>%
         gsub('NASDAQ ','', .) %>%
         gsub(' Index','', .)
   }

   
   return(group.returns)
   
}

groups <- lapply(indexes, GroupReturns)
names(groups) <- word(indexes)

dat$group.returns <- groups