leaders <- function(index, period){
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
   
   
   leaders <- head(returns, 5)
   
   return(leaders)
}