
library(shiny)
library(leaflet)
library(leaflet.extras)
source('Source.R')

navbarPage("Parking Violation", id="nav",
           #First panel: Heat map
           tabPanel(title = "Interactive Heat Map",h2(textOutput(outputId = "count1")),
                    div(class="outer", leafletOutput("heatmap"),
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = F, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      h2("Data Filter"),
                                      selectInput(inputId = 'violation', 
                                                  label = 'Violation Description', 
                                                  choices = c('All',as.vector(vio_list))))
                    )),
           #Second panel: Interactive map
           tabPanel(title = "Interactive Map", h2(textOutput(outputId = "count2")),
                    div(class="outer", leafletOutput("map"),
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      h2("Data Filter"),
                                      helpText("Note: the subset of data is based on the violation selected from heatmap panel."),
                                      selectInput(inputId = 'dayweek', 
                                                  label = 'Day of Week', 
                                                  choices = c('All','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')),
                                      sliderInput("hour",
                                                  "Range of hours:",
                                                  min = 0,  max = 23,  value = c(0,2), step = 2, 
                                                  animate = animationOptions(interval = 1000,
                                                                             playButton = icon('play', "fa-3x"),
                                                                             pauseButton = icon('pause', "fa-3x"))),
                                      plotOutput("hist", height = 250)
                                      ))
                    ),
           #Third panel: Location Searcher
           tabPanel(title = "Location Searcher", h2(textOutput(outputId = "count3")),
                    div(class="outer", leafletOutput("map2"),
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",                                    
                                      textInput(inputId = 'text',
                                                label = 'Search for a street'))
                        )
           ),
           #Fourth panel: Data explorer
           tabPanel("Data explorer",DT:: dataTableOutput("table"))
)
