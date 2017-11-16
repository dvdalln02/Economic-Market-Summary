######################################################################
######################################################################

# Retuns period returns of index members

######################################################################
######################################################################

library(stringr)

MemberReturns <- function(index){
   members <- bds(index, 'INDX_MEMBERS')[,1]
   members <- paste(members, 'Equity')
   
   member.returns <- bdp(members, return.periods)
   names(member.returns) <- gsub('CHG_PCT_','', names(member.returns))
   
   return(member.returns)
   
}

members <- lapply(indexes, MemberReturns)
names(members) <- word(indexes)

dat$member.returns <- members