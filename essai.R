# POUR LA TAILLE DE LA GRILLE POUR RAJOUTER LES NOMBRES


5%/%(2) +1
10%/%(2)
15%/%(2)+1
20%/%2
ceiling(15/2)

# METTRE LE TEXTE EN BLANC QUAND 9A AFFICHE DES 0


# POUR LA GRILLE
# SHINYJS POUR LE CLICK

# Création de la liste
ma_liste <- matrix(c(1, 2, 3, 0, 0, 0))

# Créer une liste de zéros
zeros <- ma_liste[ma_liste == 0]

# Créer une liste des valeurs non nulles
non_zeros <- ma_liste[ma_liste != 0]

# Fusionner les deux listes dans l'ordre spécifié
ma_liste_triee <- c(zeros, non_zeros)

# Afficher la liste triée
print(ma_liste_triee)


# METTRE LES ZEROS EN BLANC
# compteur de camille: rajouter des zeros pour en faire une "matric" 5x5 et
# faire ensuite ce qu'il y a au-dessus

# lapply pour la grid dans 2 boucle



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




#server <- function(input, output) {
#  output$grid <- renderUI({
#    coeff <- ceiling((input$size)/2)
#    grid <- matrix(0, nrow = input$size+coeff,ncol = input$size + coeff, byrow = TRUE)
#    
#    grid_buttons <- lapply(1:(input$size+coeff), function(i) {
#      buttons <- lapply(1:(input$size+coeff), function(j) {
#        if (i > coeff && j > coeff) {
#          div(actionButton(inputId = paste0("button", i, j), label = "", class="square-button"))
#        }
#        else if (j>coeff && i<=coeff) {
#          div(style = "width: 40px; margin-right: 3px; text-align: center;", "a")
#        }
#        else if (i>coeff && j<=coeff) {
#          div(style = "text-align: right; margin-right: 30px;", "b")
#        }
#        else {
#          div(style = "text-align: right; margin-right: 35px;", "")
#        }
#      })
#      div(style = "display: flex; justify-content: flex-start;", do.call(tagList, buttons))
#    })
#    print(grid_buttons)
#    print(grid)
#    do.call(tagList, grid_buttons)
#  })
#}



server <- function(input, output) {
  output$grid <- renderUI({
    coeff <- ceiling((input$size)/2)
    grid <- matrix(0, nrow = input$size+coeff,ncol = input$size + coeff, byrow = TRUE)
    
    button_size <- min(40, 800 / input$size)  # Ajuster la taille des boutons en fonction de la taille de la grille
    
    grid_buttons <- lapply(1:(input$size+coeff), function(i) {
      buttons <- lapply(1:(input$size+coeff), function(j) {
        if (i > coeff && j > coeff) {
          div(actionButton(inputId = paste0("button", i, j), label = "", class="square-button"), style = paste0("width: ", button_size, "px; height: ", button_size, "px;"))
        }
        else if (j>coeff && i<=coeff) {
          div(style = paste0("width: ", button_size, "px; height: ", button_size, "px; text-align: center;"), "a")
        }
        else if (i>coeff && j<=coeff) {
          div(style = paste0("width: ", button_size, "px; height: ", button_size, "px; text-align: center;"), "b")
        }
        else {
          div(style = paste0("width: ", button_size, "px; height: ", button_size, "px; text-align: center;"), " ")
        }
      })
      div(style = "display: flex; justify-content: flex-start;", do.call(tagList, buttons))
    })
    print(grid_buttons)
    print(grid)
    div(style = "width: 800px; height: 800px;", do.call(tagList, grid_buttons))  # Div de taille fixe pour la grille
  })
}

shinyApp(ui = ui, server = server)
