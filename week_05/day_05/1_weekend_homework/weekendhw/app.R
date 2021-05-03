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
                valueBoxOutput("genre", 4),
                valueBoxOutput("year_of_release"),
                valueBoxOutput("publisher"),
                valueBoxOutput("sales"),
                valueBoxOutput("critic_score"),
                valueBoxOutput("user_score"),
                valueBoxOutput("rating"),
                valueBoxOutput("platform")
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
            game_data %>%
                select(genre) %>% 
                pull()
            )
     })
    output$genre <- renderValueBox({
        valueBox(
            "Year of Release",
            game_data %>%
                select(year_of_release) %>% 
                pull()
        )
    })
    output$genre <- renderValueBox({
        valueBox(
            "Publisher",
            game_data %>%
                select(publisher) %>% 
                pull()
        )
    })
    output$genre <- renderValueBox({
        valueBox(
            "Sales",
            game_data %>%
                select(sales) %>% 
                pull()
        )
    })
    output$genre <- renderValueBox({
        valueBox(
            "Critic Score",
            game_data %>%
                select(critic_score) %>% 
                pull()
        )
    })
    output$genre <- renderValueBox({
        valueBox(
            "User Score",
            game_data %>%
                select(user_score) %>% 
                pull()
        )
    })
    output$genre <- renderValueBox({
        valueBox(
            "Rating",
            game_data %>%
                select(rating) %>% 
                pull()
        )
    })
    output$genre <- renderValueBox({
        valueBox(
            "Platform",
            game_data %>%
                select(platform) %>% 
                pull()
        )
    })
}

shinyApp(ui, server)

