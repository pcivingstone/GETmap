# server.R

server <- function(input, output, session){
  
  data <- reactive({
    x <- df
  })
  
  output$mymap <- renderLeaflet({
    df <- data()
    
    pal <- colorNumeric(
      palette = rainbow(7)
      , domain = range(df$Mw)
      )
    
    m <- leaflet(data = df) %>%
      
      addProviderTiles(
        providers$Stamen.Toner
        , group = "Black and white"
        ) %>% 
      
      addCircleMarkers(
        lng = ~long
        ,lat = ~lat
        ,radius = ~100*Mw/max(Mw)
        ,label = ~as.character(postcode)
        # ,clusterOptions = markerClusterOptions()
        ,popup = paste(
          "postcode: "
          ,df$postcode
          ,"<br>"
          ,"Installed Solar (Mw) to Feb 2019:"
          ,df$Mw
          ,"<br>"
          ,"Percentile Nationally: "
          ,df$percentile
          ,"<br>"
          ,"localities: "
          ,df$locale
        )
        ,color = ~pal(Mw)
        ,fillOpacity = 0.5
      ) %>%
      addLegend(pal = pal, values = ~Mw) %>%
      setView(lng = 144.9568, lat = -37.8174, zoom = 10)

    m
  })
  # return(output)
  output$table <- renderDataTable({
    df
  })
  
  output$chart <- renderGvis(
    gvisMotionChart(
      x
      ,idvar = 'id'
      ,timevar = 'month'
      ,xvar = 'cumulative'
      ,yvar = 'perMonth'
      ,sizevar = 'population'
      ,chartid = 'capacity'
      ,options = list(
        width = 800
        ,height = 600
      )
    )
  )
}



