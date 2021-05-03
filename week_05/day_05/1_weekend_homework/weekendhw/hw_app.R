library(tidyverse)
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(CodeClanData)

names(game_sales)

ui <- fluidPage(
    dashboardPage(
        dashboardHeader(title = ("Game Info Hub")), # trying to make this bigger
        
        dashboardSidebar(
            sidebarMenu(
                menuItem("Game Search Tab", tabName = "game_menu", icon = icon("medal"),
                         selectInput("game_search",
                                     "What Game do you want Information on?",
                                     choices = sort(unique(game_sales$name))
                         ),
                         actionButton("search", "Search")
                )
            )
        ),
        
        dashboardBody(
            #titlePanel("Game Information Summary"),
            fluidRow(
                valueBoxOutput("genre", 6),
                valueBoxOutput("year_of_release", 6),
                valueBoxOutput("publisher", 6),
                valueBoxOutput("sales", 6),
                valueBoxOutput("critic_score", 6),
                valueBoxOutput("user_score", 6),
                valueBoxOutput("rating", 6),
                valueBoxOutput("platform", 6)
                    ),
               
        )
    )
)


server <- function(input, output) {
    
    game_data <- eventReactive(input$search, {
        game_sales %>%
            filter (name == input$game_search)
    })


    
    output$genre <- renderValueBox({
        valueBox(
            "Genre",
            game_data () %>%
                select(genre) %>% 
                pull()
            )
     })
    output$year_of_release <- renderValueBox({
        valueBox(
            "Year of Release",
            game_data () %>%
                select(year_of_release) %>% 
                pull()
        )
    })
    output$publisher <- renderValueBox({
        valueBox(
            "Publisher",
            game_data () %>%
                select(publisher) %>% 
                pull()
        )
    })
    output$sales <- renderValueBox({
        valueBox(
            "Sales (million)",
            game_data () %>%
                select(sales) %>% 
                pull()
        )
    })
    output$critic_score <- renderValueBox({
        valueBox(
            "Critic Score",
            game_data () %>%
                select(critic_score) %>% 
                pull()
        )
    })
    output$user_score <- renderValueBox({
        valueBox(
            "User Score",
            game_data () %>%
                select(user_score) %>% 
                pull()
        )
    })
    output$rating <- renderValueBox({
        valueBox(
            "Rating",
            game_data () %>%
                select(rating) %>% 
                pull()
        )
    })
    output$platform <- renderValueBox({
        valueBox(
            "Platform",
            game_data () %>%
                select(platform) %>% 
                pull()
        )
    })
}

shinyApp(ui, server)

