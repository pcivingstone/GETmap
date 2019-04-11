# server.R

server <- function(input,output, session){
  
  data <- reactive({
    x <- df
  })
  
  output$mymap <- renderLeaflet({
    df <- data()
    
    m <- leaflet(data = df) %>%
      addTiles() %>%
      addMarkers(
        lng = ~long
        ,lat = ~lat
        ,popup = paste(
          "postcode ="
          ,df$postcode
          ,"<br>"
        )
      ) %>% 
      setView(lng = 145.05, lat = -37.89 , zoom = 15)
    m
  })
  # return(output)
}


