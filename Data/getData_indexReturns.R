######################################################################
######################################################################

# Get index return data from Bloomberg API

######################################################################
######################################################################

library(stringr)

index.returns <- bdp(securities = indexes,
                     fields     = return.periods)

row.names(index.returns) <- word(row.names(index.returns))
names(index.returns) <- gsub('CHG_PCT_','', names(index.returns))


dat$index.returns <- index.returns
