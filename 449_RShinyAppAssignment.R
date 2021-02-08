setwd('C:/Users/RyanB/Desktop/myRProjects')

library(shiny)
install.packages('shinydashboard')
library(shinydashboard)

ui <- dashboardPage( skin = 'purple',
  dashboardHeader(title = 'Iris Flowers'),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Iris", tabName = "iris", icon = icon("tree"))
      
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("iris",
              box(plotOutput('correlation_plot'), width = 8),
              box(
                selectInput('features', 'Features:',
                            c('Sepal.Width', 'Petal.Length', 
                              'Petal.Width')), width = 4
              )

      )
    )
   
  )
)

server <- function(input,output){
  output$correlation_plot <- renderPlot({
    plot(iris$Sepal.Length, iris[[input$features]],
         xlab = 'Sepal Length', ylab = "Feature")
  })
}

shinyApp(ui, server)




