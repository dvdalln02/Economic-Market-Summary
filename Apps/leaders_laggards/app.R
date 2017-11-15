ui <- shinyUI(
   fluidPage(
      fluidRow(
         column(4,
                tableOutput('leaders'))
      )
   

))


server <- shinyServer(function(input, output) {
   
   output$leaders <- renderTable({
      
      spx      <- bds('SPX Index', 'INDX_MEMBERS')
      spx      <- paste(spx[,1], 'Equity')
      spx      <- bdp(securities = spx, fields = 'CHG_PCT_1D')
      spx$tick <- word(row.names(spx))
      spx      <- spx[order(spx[,1]),]
      
      spxTop   <- tail(spx,5)
      # spxBtm <- head(spx, 5)


   })
})

shinyApp(ui = ui, server = server)

