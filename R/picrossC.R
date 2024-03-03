library(shiny)
library(shinyjs)

ui <- fluidPage(
  
  titlePanel("Picross"),
  
  
  sidebarLayout(
    # SIDEBAR
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
    
    # JEU ET REGLES
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




server <- function(input, output, session) {
  
  v <- reactiveValues(p=NULL, matrice=NULL, indices_lignes=NULL, indices_col=NULL, statuses=NULL)
  
  # Proportion de cases noires
  observeEvent({
    input$new
    input$size
    input$diff},{
      v$p <- difficulte(input$diff)
    })
  
  # Génération de la matrice
  observeEvent({
    input$new
    input$size
    input$diff},{
      v$matrice <- matrice_alea(input$size, v$p)
      v$statuses <- matrix(0, nrow = input$size, ncol = input$size)
    })
  
  # Indices par lignes
  observeEvent({
    input$new
    input$size
    input$diff},{
      v$indices_lignes <- compteur(v$matrice,0)
    })
  
  # Indices par colonnes
  observeEvent({
    input$new
    input$size
    input$diff},{
      v$indices_col <- t(compteur(v$matrice,1))
    })
  
  output$grid <- renderUI({
    
    # On calcule le nombre maximal d'indices sur les côtés de la grille
    coeff <- ceiling((input$size)/2)
    
    # On ajuste la taille des boutons en fonction de la taille de la grille
    button_size <- min(40, 800 / (2*input$size))
    
    # CSS pour la taille des boutons
    button_css <- paste0(".square-button { width: ", button_size, "px; height: ", button_size, "px; }")
    
    # On génère la grille de boutons
    grid_buttons <- lapply(1:(input$size+coeff), function(i) {
      buttons <- lapply(1:(input$size+coeff), function(j) {
        if (i > coeff && j > coeff) {
          # data_status="0" pour initialiser le statut des boutons et éviter de
          # cliquer au début de la partie
          div(actionButton(inputId = paste0("button_", i,"_", j), label = "", 
                           class="square-button", style="color:black;", 
                           "data-status"="0"))  
        }
        else if (j>coeff && i<=coeff) {
          div(style = paste0("width: ", button_size, "px; text-align: center;"), 
              v$indices_col[i,j-coeff])
        }
        else if (i>coeff && j<=coeff) {
          div(style = paste0("width: ", button_size, "px; text-align: center;"), 
              v$indices_lignes[i-coeff,j])
        }
        else {
          div(style = paste0("width: ", button_size, "px; text-align: center;"), " ")
        }
      })
      div(style = "display: flex; justify-content: flex-start; align-items: center;", do.call(tagList, buttons))
    })
    
    # Add custom JavaScript to change button color and update status matrix
    js <- "
      $('.square-button').click(function() {
        var status = parseInt($(this).data('status'));
  
        // Extract the row and column from the button_id
        var id = $(this).attr('id'); 
        var indices = id.split('_'); // Split the id on the underscore character
        var row = parseInt(indices[1]); // The row is the second element of the array
        var col = parseInt(indices[2]); // The column is the third element of the array
        if (status === 0) {
          $(this).css('background-color', 'black');
          $(this).data('status', 1);
          Shiny.setInputValue('status_changed', {row: row, col: col, status: 1}); // On envoie le nouveau statut au server
        } else if (status === 1) {
          $(this).html('<span style=\"color:red;\">X</span>');
          $(this).css('background-color', 'white');
          $(this).data('status', 2);
          Shiny.setInputValue('status_changed', {row: row, col: col, status: 2}); // On envoie le nouveau statut au server
        } else {
          $(this).html('');
          $(this).css('background-color', 'white');
          $(this).data('status', 0);
          Shiny.setInputValue('status_changed', {row: row, col: col, status: 0}); // On envoie le nouveau statut au server
        }
      });
    "
    
    tagList(
      # On injecte le CSS dans l'application
      tags$style(button_css), 
      tags$script(HTML(js)),
      #On fixe un taille maximale pour la grille de jeu
      div(style = "width: 800px; height: 800px;", do.call(tagList, grid_buttons))
    )
  })
  
  observeEvent(input$status_changed, {
    # On calcule le nombre maximal d'indices sur les côtés de la grille
    coeff <- ceiling((input$size)/2)
    
    # On extrait les indices des id des boutons
    row_index <- input$status_changed$row - coeff
    
    col_index <- input$status_changed$col - coeff
    
    print(c(row_index, col_index))
    print(coeff)
    
    # Check if row and column indices are within bounds of action button grid
    if (!is.na(row_index) && !is.na(col_index) &&
        row_index >= 1 && row_index < (input$size+coeff) &&
        col_index >= 1 && col_index < (input$size+coeff)) {
      v$statuses[row_index, col_index] <- input$status_changed$status
      print(v$statuses)
    } else {
      print("Index out of bounds or invalid")
    }
  })
}


shinyApp(ui = ui, server = server)
