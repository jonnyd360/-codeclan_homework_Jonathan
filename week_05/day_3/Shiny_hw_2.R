library(tidyverse)
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(CodeClanData)

ui <- fluidPage(
dashboardPage(
    header <- dashboardHeader(title = tags$i(tag$h1("Five Country Olympic Medal Comparison"))), # trying to make this bigger
    sidebar <- dashboardSidebar(
        sidebarMenu(
            menuItem("Get Set Go!", tabName = "medal", icon = icon("medal"),
                     selectInput("season_button",
                                 "Summer or Winter Olympics?",
                                 choices = c("Summer", "Winter")
                                 ),
                     radioButtons("medal_button",
                                  "Compare Which Medals?",
                                  choices = c("Gold", "Silver", "Bronze")
                                  )
            )
        )
        
    ),
        
    body <- dashboardBody(
        title = tags$i("Selected Medal Plot"), #the italics is not working
        plotOutput("medal_plot") # want an empty plot to start with
    )
    )
)
    

server <- function(input, output) {
    
    
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal_button) %>%
            filter(season == input$season_button) %>%
            ggplot() +
            aes(x = team, y = count, fill = medal) +
            geom_col() + 
            scale_fill_manual(values = c("Gold" = "#F5B041", 
                                         "Silver" = "#808B96", 
                                         "Bronze" = "#DC7633")
                             ) +
            labs (
                x = "\nTeam",
                y = "Meadal Count\n",
                fill = "Medal Type")
        
        
    })
}

shinyApp(ui, server)

