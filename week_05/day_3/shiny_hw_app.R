
library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)

ui <- fluidPage(
    
    titlePanel("Five Country Medal Comparison"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("season_button",
                         "Summer or Winter Olympics?",
                         choices = c("Summer", "Winter")
            ),
            
            radioButtons("medal_button",
                         "Compare Which Medals?",
                         choices = c("Gold", "Silver", "Bronze")
            )
        ),
        
        mainPanel(
            plotOutput("medal_plot"),
            tabPanel("website",
                     tags$a("The Olympics website", href = "https://www.olympic.org")
            )
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
                                         "Bronze" = "#DC7633"))
        
        
    })
}

shinyApp(ui = ui, server = server)

