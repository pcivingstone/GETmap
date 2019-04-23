# server.R

server <- function(input, output, session){
  
  data <- reactive({
    x <- df
  })
  
  output$mymap <- renderLeaflet({
    df <- data()
    
    pal <- colorNumeric(
      # palette = 'Dark2'
      # palette = 'PuOr'
      # palette = heat.colors(9, alpha = 0.9)
      palette = rainbow(7)
      # palette = 'Spectral'
      # palette = 'Set1'
      , domain = range(df$kw)
      # , alpha = TRUE
      )
    
    m <- leaflet(data = df) %>%
      # addProviderTiles("Esri.WorldImagery") %>%
      addProviderTiles("Esri.WorldTopoMap") %>%
      # addTiles() %>%
      # addMarkers(
      #   lng = ~long
      #   ,lat = ~lat
      #   ,clusterOptions = markerClusterOptions()
      #   ,popup = paste(
      #     "postcode ="
      #     ,df$postcode
      #     ,"<br>"
      #   )
      # ) %>%
      # addCircleMarkers(
      addCircles(
        lng = ~long
        ,lat = ~lat
        ,radius = ~1e4*kw/max(kw)
        ,label = ~as.character(postcode)
        # ,clusterOptions = markerClusterOptions()
        ,popup = paste(
          "postcode: "
          ,df$postcode
          ,"<br>"
          ,"localities: "
          ,df$locale
          ,"<br>"
          ,"Installed Solar (kw) to Feb 2019:"
          ,df$kw
          ,"<br>"
          ,"Percentile Nationally: "
          ,df$percentile
        )
        ,color = ~pal(kw)
        # , color = 'black'
        ,fillOpacity = 0.5
      ) %>% 
      setView(lng = 145.05, lat = -37.89 , zoom = 12) %>% 
      # addMiniMap()
      addScaleBar(options = scaleBarOptions(imperial = F)) %>% 
      addLegend(pal = pal, values = ~kw)
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
        width = 600
        ,height = 600
      )
    )
  )
}



