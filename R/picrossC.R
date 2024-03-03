library(shiny)

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
        min = 5, max = 15,
        value = 5, step = 1),
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



server <- function(input, output) {
  v <- reactiveValues(p=NULL, matrice=NULL, indices_lignes=NULL, undices_col=NULL)
  
  observeEvent({
    input$new
    input$size},{    
    v$p <- difficulte(input$diff)
    v$matrice <- matrice_alea(input$size, v$p)
    v$indices_lignes <- compteur(v$matrice,0)
    v$indices_col <- t(compteur(v$matrice,1))
  
  
  output$grid <- renderUI({
    coeff <- ceiling((input$size)/2)
    grid <- matrix(0, nrow = input$size+coeff, ncol = input$size + coeff, byrow = TRUE)
    
    button_size <- min(40, 800 / (2*input$size))  # Adjust button size based on grid size
    
    # Generate CSS for square-button class
    button_css <- paste0(".square-button { width: ", button_size, "px; height: ", button_size, "px; }")
    
    grid_buttons <- lapply(1:(input$size+coeff), function(i) {
      buttons <- lapply(1:(input$size+coeff), function(j) {
        if (i > coeff && j > coeff) {
          div(actionButton(inputId = paste0("button", i, j), label = "", class="square-button"))
        }
        else if (j>coeff && i<=coeff) {
          div(style = paste0("width: ", button_size, "px; text-align: center;"), v$indices_col[i,j-coeff])
        }
        else if (i>coeff && j<=coeff) {
          div(style = paste0("width: ", button_size, "px; text-align: center;"), v$indices_lignes[i-coeff,j])
        }
        else {
          div(style = paste0("width: ", button_size, "px; text-align: center;"), " ")
        }
      })
      div(style = "display: flex; justify-content: flex-start; align-items: center;", do.call(tagList, buttons))
    })
    # print(grid_buttons)
    # print(grid)
    # print(p)
    print(v$matrice)
    tagList(
      tags$style(button_css),  # Inject CSS into the app
      div(style = "width: 800px; height: 800px;", do.call(tagList, grid_buttons))  # Fixed-size div for the grid
    )
  })
  })
}

shinyApp(ui = ui, server = server)
