# server.R

server <- function(input, output, session){
  
  data <- reactive({
    x <- df
  })
  
  output$mymap <- renderLeaflet({
    df <- data()
    
    pal <- colorNumeric(
      # palette = 'Dark2'
      palette = 'OrRd'
      # palette = 'Spectral'
      # palette = 'Set1'
      , domain = range(df$kw)
      )
    
    m <- leaflet(data = df) %>%
      addProviderTiles("Esri.WorldImagery") %>%
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
      addCircleMarkers(
      # addCircles(
        lng = ~long
        ,lat = ~lat
        ,radius = ~100*kw/max(kw)
        ,label = ~as.character(postcode)
        # ,clusterOptions = markerClusterOptions()
        ,popup = paste(
          "postcode: "
          ,df$postcode
          ,"<br>"
          ,"Installed Solar (kw):"
          ,df$kw
        )
        ,color = ~pal(kw)
        # , color = 'black'
        ,fillOpacity = 1
      ) %>% 
      setView(lng = 145.05, lat = -37.89 , zoom = 12) %>% 
      # addMiniMap()
      addScaleBar(options = scaleBarOptions(imperial = F)) %>% 
      addLegend(pal = pal, values = ~kw)
    m
  })
  # return(output)
}


