path <- 'R:/David/Projects/Economic & Market Summary/Apps/index_returns'

source(paste0(path, '/LeadersLaggards.R'))
source(paste0(path, '/PdRet.R'))


library(shiny)
library(shinyjs)

shinyApp(
   
   ui = fluidPage(
      
      shinyjs::useShinyjs(),
      
      # Index Returns UI ---------------------------------------------------
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
         # Action Buttons On/Off -----------------------------------------------         
         
         # Leaders/laggards buttons
         column(6,
                actionButton('leadersLaggardsOff',label = NULL,
                             icon = icon('list'),
                             style = "color: white; 
                               background-color: #850237"),
                
                
                hidden(actionButton('leadersLaggardsOn', label = NULL,
                                    icon = icon('list'),
                                    style = "color: #850237;
                                       background-color: white"))
         ),
         
         # Index group returns buttons on/off
         column(6,
                actionButton('groupReturnsOff',label = NULL,
                             icon = icon('bar-chart'),
                             style = "color: white; 
                             background-color: #850237"),
                
                
                hidden(actionButton('groupReturnsOn', label = NULL,
                                    icon = icon('bar-chart'),
                                    style = "color: #850237;
                                    background-color: white")))
         
      ),
      
      br(),
      
      fluidRow(
         hidden(radioButtons('leadLagCount', 
                             label = 'Number of Leaders/Laggards',
                             choices = list(5,10,20),
                             inline = TRUE)
                
         )),
      
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
      
      # Index Period Returns -----------------------------------------------    
      
      # Display index return for selected period
      output$spx  <- renderText({PdRet('SPX',  input$pdSelect)})
      output$indu <- renderText({PdRet('INDU', input$pdSelect)})
      output$ccmp <- renderText({PdRet('CCMP', input$pdSelect)})
      
      # Leaders/Laggards ---------------------------------------------------  
      
      # Toggle UI elements on actionButton 
      observeEvent(input$leadersLaggardsOff,{
         
         toggle('leadersLaggardsOn')
         toggle('leadersLaggardsOff')
         
         toggle('leadLagCount')
         
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
      
      observeEvent(input$leadersLaggardsOn, {
         toggle('leadersLaggardsOn')
         toggle('leadersLaggardsOff')
         
         toggle('leadLagCount')
         
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
      
      # Determine index leaders and laggards based on selected period
      spxll  <- reactive({LeadersLaggards('SPX' , input$pdSelect)})
      indull <- reactive({LeadersLaggards('INDU', input$pdSelect)})
      ccmpll <- reactive({LeadersLaggards('CCMP', input$pdSelect)})
      
      # Display selected number of index leaders and laggards
      output$spxTop  <- renderTable({
         head(spxll()$leaders, as.numeric(input$leadLagCount))},
         colnames = FALSE)
      
      output$induTop <- renderTable({
         head(indull()$leaders, as.numeric(input$leadLagCount))}, 
         colnames = FALSE)
      
      output$ccmpTop <- renderTable({
         head(ccmpll()$leaders, as.numeric(input$leadLagCount))}, 
         colnames = FALSE)
      
      output$spxBtm  <- renderTable({
         head(spxll()$laggards, as.numeric(input$leadLagCount))},
         colnames = FALSE)
      
      output$induBtm <- renderTable({
         head(indull()$laggards, as.numeric(input$leadLagCount))},
         colnames = FALSE)
      
      output$ccmpBtm <- renderTable({
         head(ccmpll()$laggards, as.numeric(input$leadLagCount))},
         colnames = FALSE)
      
      
      
      # Index Group Returns -------------------------------------------
      
      # Toggle UI elements on actionButton 
      observeEvent(input$groupReturnsOff,{
         
         toggle('groupReturnsOn')
         toggle('groupReturnsOff')
         
         toggle('leadLagCount')
         
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
   },
   
   
   options = list(height = '1000px')
   
)



