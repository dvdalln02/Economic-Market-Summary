library(shiny)
library(magrittr)

shinyApp(
   
   ui = fluidPage(
      
      fluidRow(
         radioButtons('pdSelect', '',
                      choices = c('1 Day'   = '1D',
                                  '5 Day'   = '5D',
                                  '1 Month' = '1M',
                                  '3 Month' = '3M',
                                  '6 Month' = '6M',
                                  '1 Year'  = '1YR'),
                      inline = TRUE)
      ),
      
      fluidRow(
         column(4,
                align = 'center',
                h2('S&P 500'),
                textOutput("spx"),
                tags$head(tags$style("#spx{
                                     color: #850237;
                                     font-size: 30px;
                                     font-style: bold;}")
                )
         ),
         
         column(4,
                align = 'center',
                h2('Dow Jones'),
                textOutput("indu"),
                tags$head(tags$style("#indu{
                                     color: #850237;
                                     font-size: 30px;
                                     font-style: bold;}")
                )
         ),
         column(4,
                align = 'center',
                h2('NASDAQ'),
                textOutput("ccmp"),
                tags$head(tags$style("#ccmp{
                                     color: #850237;
                                     font-size: 30px;
                                     font-style: bold;}")
                )
         )
         
         
         
      )),
   
   server = function(input, output) {
      
      output$spx <- renderText({
         fld <- paste0('CHG_PCT_', input$pdSelect)
         bdp('SPX Index',fld)[[1]] %>% 
            format(digits = 2) %>%
            paste0('%')
      })
      
      output$indu <- renderText({
         fld <- paste0('CHG_PCT_', input$pdSelect)
         bdp('INDU Index',fld)[[1]] %>% 
            format(digits = 2) %>%
            paste0('%')})
      
      output$ccmp <- renderText({
         fld <- paste0('CHG_PCT_', input$pdSelect)
         bdp('CCMP Index',fld)[[1]] %>% 
            format(digits = 2) %>%
            paste0('%')})
   }
   
)