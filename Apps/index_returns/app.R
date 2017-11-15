source('R:/David/Projects/Economic & Market Summary/Apps/index_returns/LeadersLaggards.R')

library(shiny)
library(shinyjs)

shinyApp(
   
   ui = fluidPage(
      
      shinyjs::useShinyjs(),
      
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
                ),
                hr()
         ),
         
         column(4,
                align = 'center',
                h2('Dow Jones'),
                textOutput("indu"),
                tags$head(tags$style("#indu{
                                     color: #850237;
                                     font-size: 30px;
                                     font-style: bold;}")
                ),
                hr()
         ),
         column(4,
                align = 'center',
                h2('NASDAQ'),
                textOutput("ccmp"),
                tags$head(tags$style("#ccmp{
                                     color: #850237;
                                     font-size: 30px;
                                     font-style: bold;}")
                ),
                hr()
         )
         
         
         
      ),
      fluidRow(
         actionButton('leadersLaggards',label = NULL,
                      icon = icon('list'),
                      style = "color: white; 
                               background-color: #850237")
         
      ),
         fluidRow(
            column(4,
                   align = 'center',
                   hidden(h3(id = 'spx-lead','Leaders')),
                   hidden(tableOutput('spxTop')),
                   hidden(h3(id = 'spx-lag', 'Laggards')),
                   hidden(tableOutput('spxBtm'))),
            
            column(4,
                   align = 'center',
                   hidden(h3(id = 'indu-lead', 'Leaders')),
                   hidden(tableOutput('induTop')),
                   hidden(h3(id = 'indu-lag', 'Laggards')),
                   hidden(tableOutput('induBtm'))),
            
            column(4,
                   align = 'center',
                   hidden(h3(id = 'ccmp-lead', 'Leaders')),
                   hidden(tableOutput('ccmpTop')),
                   hidden(h3(id = 'ccmp-lag', 'Laggards')),
                   hidden(tableOutput('ccmpBtm')))
         )

),
   
   server = function(input, output) {
      
      observeEvent(input$leadersLaggards,{
      
         toggle('spx-lead')
         toggle('spxTop')
         toggle('spx-lag')
         toggle('spxBtm')
         
         toggle('indu-lead')
         toggle('induTop')
         toggle('indu-lag')
         toggle('induBtm')
         
         toggle('ccmp-lead')
         toggle('ccmpTop')
         toggle('ccmp-lag')
         toggle('ccmpBtm')
      })
      
      spxll  <- reactive({LeadersLaggards('SPX', input$pdSelect)})
      indull <- reactive({LeadersLaggards('INDU', input$pdSelect)})
      ccmpll <- reactive({LeadersLaggards('CCMP', input$pdSelect)})
      
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
      
#####################################################################
      output$spxTop  <- renderTable({spxll()$leaders},
                                    colnames = FALSE)
      output$induTop <- renderTable({indull()$leaders},
                                    colnames = FALSE)
      output$ccmpTop <- renderTable({ccmpll()$leaders},
                                    colnames = FALSE)
      
      output$spxBtm  <- renderTable({spxll()$laggards},
                                    colnames = FALSE)
      output$induBtm <- renderTable({indull()$laggards},
                                    colnames = FALSE)
      output$ccmpBtm <- renderTable({ccmpll()$laggards},
                                    colnames = FALSE)
      

   },

options = list(height = '1000px')
   
)