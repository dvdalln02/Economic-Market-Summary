######################################################################
######################################################################

# Creates plot of index group/member returns

######################################################################
######################################################################

GroupReturnPlot <- function(index, period){
   
   dat <- dat$group.returns[[index]]
   
   dat <- data.frame(label = dat[, ncol(dat)],
                     return = dat[, period])
   
   dat <- dat[order(dat$return),]
   
   levels(dat$label) <- dat$label[order(dat$return)]
   
   # if(!is.factor(dat$label)){
   #    dat$label <- factor(levels = dat$label[order(dat$return)])
   # } else {
   #    levels(dat$label) <- dat$label[order(dat$return)]
   # }
   
   
   library(ggplot2)
   
   # plot.labels <- gsub(' ','\n', dat$label[order(dat$return)])
   
   p <- ggplot(dat, aes(label, return)) +
      geom_bar(stat = 'identity', fill = '#850237') +
      # scale_x_discrete(labels = plot.labels) +
      theme_bw()
   
   
   return(p)
}