# ui.R

ui <- fluidPage(
  titlePanel("Installed Solar Panel Capacity by Postcode at Feb 2019")
  # ,sidebarPanel(
  #   dateInput(
  #     'month'
  #     ,'Select month to display:'
  #     ,value = '2019-02-01'
  #     ,format = 'yyyy-mm'
  #     )
  #   ,textInput('postcode','Select postcode to centre:',value = '1234')
  # )
  ,mainPanel(
    tabsetPanel(
      tabPanel(
        'Interactive Map'
        ,leafletOutput(
          "mymap"
          ,height = 700
          # ,height = '100%'
          )
      )
      ,tabPanel(
        'Table'
        ,dataTableOutput('table')
        )
      ,tabPanel(
        'Motion Chart'
        ,htmlOutput('chart')
      )
      )
    )
  )
