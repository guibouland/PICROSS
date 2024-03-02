library(shiny)

ui <- fluidPage(
  
  # Détection des clics
  detect <- tags$head(
    tags$script(HTML('
      $(document).on("click", ".btn-square", function() {
        $(this).toggleClass("clicked");
      });
    '))
  ),
  tags$head(
    tags$style(HTML("
                    .square-button {
                      width: 40px;
                      height: 40px;
                      border-radius: 0;
                      margin-bottom: 3px;
                      border-radius: 10px;
                    }
                    .custom-matrix {
                      margin-bottom: 3px;
                    }"))
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
                        tags$style(type="text/css", ".btn-group { margin-bottom: 2px; }"),
                        tags$style(type="text/css", "#grid {border-collapse: separate; border-spacing: 2px;}"), # style pour délimiter les cellules
                        uiOutput("grid")
                 )
               )),
        tabPanel("Rules", 
               tags$h1("Game rules"),
               tags$br(),
               "Game rules description")
      ),
    )
  )
)

#server <- function(input, output, session) { 
#  output$grid <- renderUI({
#    matrix_data <- matrix(" ", nrow = input$size + 1, ncol = input$size + 1)
#    
#    button_list <- list()  # Liste pour stocker les boutons
#    
#    for (i in 1:(input$size + 1)) {
#      button_row <- list()  # Liste pour stocker les boutons de chaque ligne
#      for (j in 1:(input$size + 1)) {
#        if (i > 1 && j > 1) {
#          button_row[[j]] <- actionButton(inputId = paste0("button", i, j), label = " ", class = "square-button")
#        }
#      }
#      button_list[[i]] <- div(style = "display: center; flex-direction: row;", button_row)  # Ajout de la ligne de boutons à la liste principale
#    }
#    
#    # Convertir la liste en tagList
#    tagList(button_list)
#  })
#}


server <- function(input, output) {
  output$grid <- renderUI({
    grid <- matrix(0, nrow = input$size+1,ncol = input$size + 1, byrow = TRUE)
    
    grid_buttons <- lapply(1:(input$size+1), function(i) {
      buttons <- lapply(1:(input$size+1), function(j) {
        if (i > 1 && j > 1) {
          actionButton(inputId = paste0("button", i, j), label = "", class="square-button")
        }
        else {
          paste("a b")
        }
      })
      fluidRow(do.call(tagList, buttons))
    })
    print(grid_buttons)
    print(grid)
    do.call(tagList, grid_buttons)
  })
}







shinyApp(ui = ui, server = server)

  