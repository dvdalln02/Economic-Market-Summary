LeadersLaggards <- function(index, period){
   index <- paste(index, 'Index')
   fld <- paste0('CHG_PCT_', period)
   
   members <- bds(index, 'INDX_MEMBERS')
   members <- paste(members[,1], 'Equity')
   
   returns <- bdp(members, fld)
   names(returns) <- 'return'
   returns$tick <- word(row.names(returns))
   returns <- returns[order(returns$return, decreasing = TRUE),]
   row.names(returns) <- NULL
   returns <- data.frame(tick   = returns$tick, 
                         return = returns$return)
   
   
   lead <- head(returns, 5)
   
   lag <- returns[order(returns$return),] %>%
      head(5)
   
   topBtm <- list(leaders = lead,
                  laggards = lag)
   
   return(topBtm)
}