##Packages leaflet, leaflet.extras, tidyr, DT and data.table are required to run the app.
#'ticket.png' and 'Parking_Violations_Issued_in_September_2017.csv' file are required to place in the same folder as .r files.

library(shiny)
library(leaflet)
library(leaflet.extras)
library(tidyr)
library(DT)
library(data.table)
source('Source.R')

shinyServer(function(input, output,session) {
  ## Interactive Heat Map ###########################################
  # Create the heatmap
  output$heatmap <- renderLeaflet({
    data = heatmap_filter()
    points = cbind(data$X, data$Y)
    leaflet() %>%
    addTiles() %>%
    addWebGLHeatmap(data = points, size = 300, opacity = 0.8)
  })
  
  # A reactive expression that returns the choice of violation selected right now
  heatmap_filter <- reactive({
    if (input$violation == 'All'){
      return(data)}
    else {
      violat = input$violation}
    subset(data, VIOLATION_DESCRIPTION == violat)
  })
  
  # Output the number of tickets of the heatmap subset
  output$count1 <- renderText({
    paste("Number of tickets:", nrow(heatmap_filter()))
  })
  
  
  ## Interactive Map ###########################################
  # Create the map
  output$map <- renderLeaflet({
    data = map_filter()
    points = cbind(data$X, data$Y)
    leaflet() %>%
    addTiles() %>%
    addMarkers(data = points, icon = makeIcon(iconUrl ="ticket.png",
                    iconWidth = 20, iconHeight = 20,
                    iconAnchorX = 0, iconAnchorY = 20)) %>%
    setView(lng = -77, lat = 38.9, zoom = 11)
  })
  
  # Output the number of tickets of the map subset
    output$count2 <- renderText({
    paste("Number of tickets:", nrow(map_filter()))
  })
    
  # A reactive expression that returns the set day of week and hours selected right now
  map_filter <- reactive({
  if (input$dayweek == 'All'){
    dw = as.list(unique(unlist(data$DAY_OF_WEEK)))}
  else {
  dw = input$dayweek}
  min_hour = as.integer(input$hour[1])
  max_hour = as.integer(input$hour[2])
  st = input$street
  subset(heatmap_filter(), (DAY_OF_WEEK %in% dw) & HOUR >= min_hour & HOUR <= max_hour)
  })
  
  # Create a histogram to show the ticket counts based on days of week
  output$hist <- renderPlot({
    dw_freq <- table(map_filter()[, 'DAY_OF_WEEK']) %>% as.data.frame
    dw_freq <- dw_freq[with(dw_freq, order(-Freq)),] %>% as.data.frame
    dw_freq$Var1 <- factor(dw_freq$Var1 , levels= c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
    dw_freq <- dw_freq[order(dw_freq$Var1), ]
    freq_bar = barplot(dw_freq$Freq, main ='Frequency', names.arg=dw_freq$Var1, col = 'lightblue',las = 2)
    text(freq_bar, dw_freq$Freq, paste(dw_freq$Freq)) 
  })
  
  
  ## Location Searcher ###########################################
  # Create the map
  output$map2 <- renderLeaflet({
    data = locat_filter()
    points = cbind(data$X, data$Y)
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = points, icon = makeIcon(iconUrl ="ticket.png",
                                                iconWidth = 20, iconHeight = 20,
                                                iconAnchorX = 0, iconAnchorY = 20))
  })  
  
  locat_filter <- reactive({
    location = input$text
    subset(data, tolower(data$LOCATION) %like% tolower(location))
  })
  
  output$count3 <- renderText({
    paste("Number of tickets:", nrow(locat_filter()))
  })
  
  
  #Create a table shows the selected data in location searcher
  output$table <- renderDataTable({
    DT::datatable(locat_filter(), options = list(pagelength = 25))
  })
})  

