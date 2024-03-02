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

#
#server <- function(input, output) {
#  output$grid <- renderUI({
#    coeff <- ceiling((input$size)/2)
#    grid <- matrix(0, nrow = input$size+coeff,ncol = input$size + coeff, byrow = TRUE)
#    
#    grid_buttons <- lapply(1:(input$size+coeff), function(i) {
#      buttons <- lapply(1:(input$size+coeff), function(j) {
#        if (i > coeff && j > coeff) {
#          actionButton(inputId = paste0("button", i, j), label = "", class="square-button")
#        }
#        else if (j>coeff && i<=coeff) {
#          div(style = "text-align: center;", "a")  # Ajout de la div pour centrer le texte
#        }
#        else if (i>coeff && j<=coeff) {
#          paste("b")
#        }
#        else {
#          paste("v")
#        }
#      })
#      fluidRow(do.call(tagList, buttons))
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
    
    grid_buttons <- lapply(1:(input$size+coeff), function(i) {
      buttons <- lapply(1:(input$size+coeff), function(j) {
        if (i > coeff && j > coeff) {
          div(actionButton(inputId = paste0("button", i, j), label = "", class="square-button"))
        }
        else if (j>coeff && i<=coeff) {
          div(style = "text-align: center; margin-right: 30px;", "a")
        }
        else if (i>coeff && j<=coeff) {
          div(style = "text-align: center; margin-right: 30px;", "b")
        }
        else {
          div(style = "text-align: center; margin-right: 30px;", "v")
        }
      })
      div(style = "display: flex; justify-content: center;", do.call(tagList, buttons))
    })
    print(grid_buttons)
    print(grid)
    do.call(tagList, grid_buttons)
  })
}


shinyApp(ui = ui, server = server)

