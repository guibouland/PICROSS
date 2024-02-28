ui <- fluidPage(
  
  titlePanel("Picross"),
  
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      tags$p(tags$b("Options")),
      
      # Bouton NEW
      actionButton(
        inputId = "new",
        label = "New"),
      tags$br(),
      
      # Bouton RESET
      actionButton(
        inputId = "reset",
        label = "Reset"),
      tags$br(),
      tags$br(),
      
      # slider TAILLE
      sliderInput(
        inputId = "size",
        label = "Size:",
        min = 5, max = 20,
        value = 5, step = 5),
      tags$br(),
      
      # menu DIFFICULTE
      
      
      # bouton VERIFICATION
      actionButton(
        inputId = "verif",
        label = "Verification"
      )
    ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Game", 
               fluidRow(
                 column(width = 6,
                        tags$style(type="text/css", "#grid {border-collapse: separate; border-spacing: 10px;}"), # style pour délimiter les cellules
                        tableOutput("grid")
                 )
               )),
      tabPanel("Rules", 
               tags$h1("Game rules"),
               tags$br(),
               "Game rules description")
    ),
  )
))



server <- function (input, output, session) { 
  output$grid <- renderTable({
    matrix_data <- matrix(" ", nrow = input$diff + 1, ncol = input$diff + 1)
    
    for (i in 2:input$diff + 1) {
      for (j in 2:input$diff + 1) {
        matrix_data[i, j] <- actionButton(inputId = paste0("button", i, j), label = " ")
      }
    }
    matrix_data
  },
  sanitize.text.function = function(x) x)
}


shinyApp(ui = ui, server = server)

  