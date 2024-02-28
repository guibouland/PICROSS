

ui <- fluidPage(
  
  # Détection des clics
  detect <- tags$head(
    tags$script(HTML('
      $(document).on("click", ".btn-square", function() {
        $(this).toggleClass("clicked");
      });
    '))
  ),
  
  
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
      selectInput(inputId ="diff",
                  label = "Difficulty:",
                  choices = c("Easy", "Medium", "Hard"),
                  selected = "Easy"),
      
      # bouton VERIFICATION
      actionButton(
        inputId = "verif",
        label = "Check"
      )
    ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Game", 
               fluidRow(
                 column(width = 12,
                        tags$style(type="text/css", "#grid {border-collapse: separate; border-spacing: 10px;}"), # style pour délimiter les cellules
                        uiOutput("grid")
                 ),
                 tags$head(
                   tags$style(HTML("
                    .square-button {
                      width: 50px;
                      height: 50px;
                    }"))
                 )
               )),
      tabPanel("Rules", 
               tags$h1("Game rules"),
               tags$br(),
               "Game rules description")
    ),
  )
))




server <- function(input, output, session) { 
  output$grid <- renderUI({
    matrix_data <- matrix(" ", nrow = input$size + 1, ncol = input$size + 1)
    button_list <- list()  # Liste pour stocker les boutons
    
    for (i in 1:(input$size + 1)) {
      button_row <- list()  # Liste pour stocker les boutons de chaque ligne
      for (j in 1:(input$size + 1)) {
        if (i > 1 && j > 1) {
          button_row[[j]] <- actionButton(inputId = paste0("button", i, j), label = " ", width = "50px", height = "50px")
        }
      }
      button_list[[i]] <- div(style = "display: flex; flex-direction: row;", button_row)  # Ajout de la ligne de boutons à la liste principale
    }
    
    # Convertir la liste en tagList
    tagList(button_list)
  })
}





shinyApp(ui = ui, server = server)

  