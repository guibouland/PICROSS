
ui <- fluidPage(
   
  # tags$head(tags$script(src = "message-handler.js")),
  titlePanel("Picross"),
  tags$head(
    tags$style(
      HTML(".shiny-notification {
             position:fixed;
             top: calc(30%);
             left: calc(50%);
             width: 320px;
             font-size: 25px; /* Taille de police */
             color: red; /* Couleur de police */
             }
            .square-button {
              position: relative;
            }

            .red-x {
              color: red;
              position: absolute;
              top: 50%;
              left: 50%;
              transform: translate(-50%, -50%);
            }
            "
      )
    ),
    tags$script("
      Shiny.addCustomMessageHandler('jsCode', function(message) {
        eval(message);
      });
    ")
  ),
  
  sidebarLayout(
    # SIDEBAR
    sidebarPanel(
      width = 3,
      tags$h3(tags$b("Options :")),
      tags$br(),
      div(style="text-align:center;",
        # Bouton NEW
        actionButton(
          inputId = "new",
          label = "Nouveau",
          style="color: white; background-color: #2ca02c; padding: 15px 32px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer;"),
        tags$br(),
        
        # Bouton RESET
        actionButton(
          inputId = "reset",
          label = "Réinitialiser",
          style = "color: white; background-color: #1f77b4; padding: 15px 32px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer;"),
        tags$br(),
        
        # bouton VERIFICATION
        actionButton(
        inputId = "verif",
        label = "Vérification",
        style = "color: white; background-color: #ff7f0e; padding: 15px 32px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer;")),
      
      tags$br(),

      # slider TAILLE
      sliderInput(
        inputId = "size",
        label = "Taille :",
        min = 5, max = 15,
        value = 5, step = 1),
      tags$br(),
      
      # menu DIFFICULTE
      selectInput(inputId ="diff",
                  label = "Difficulté :",
                  choices = c("Facile", "Moyen", "Difficile"), # Ne peut pas être changé en français sinon l'app ne s'ouvre plus
                  selected = "Facile")
      
      
    ),
    
    # JEU ET REGLES
    mainPanel(
      width = 9,
      tabsetPanel(
        tabPanel("Jeu", 
                 fluidRow(
                   column(width = 12,
                          tags$style(type="text/css", ".btn-group { margin-bottom: 2px; }"),
                          tags$style(type="text/css", "#grid {border-collapse: separate; border-spacing: 2px;}"), # style pour délimiter les cellules
                          div(style="display: flex; justify-content: center; align-items: center; height: 100%;", # Centrer la grille
                            uiOutput("grid")
                          ),
                          textOutput('message')
                   )
                 )
        ),
        tabPanel("Règles", 
                   tags$h1("Règles du Jeu"),
                   tags$br(),
                   tags$h3("Description du jeu"),
                   tags$p("Le Picross est un jeu de réflexion qui consiste à découvrir une image cachée en remplissant des cases d'une grille. Chaque case est soit noire, soit blanche. Les indices situés à gauche de la grille indiquent le nombre de cases noires à remplir sur chaque ligne, et les indices situés en haut de la grille indiquent le nombre de cases noires à remplir sur chaque colonne."),
                   tags$br(),
                   tags$h3("Comment jouer ?"),
                   tags$p("Vous pouvez cliquer sur une case pour la remplir en noir, et recliquer dessus pour faire apparaître une croix rouge, indiquant alors que la dite case ne doit pas être noircie. Un dernier permettra de revenir à la case blanche."),
                   tags$br(),
                   tags$h3("Options"),
                   tags$p("Sur la gauche du jeu, vous trouverez différentes options telles que :"),
                   tags$ul(
                     tags$li(
                       tags$b("Nouveau"), " : pour générer une nouvelle grille"
                     ),
                     tags$li(
                       tags$b("Réinitialiser"), " : pour effacer la grille actuelle et recommencer"
                     ),
                     tags$li(
                       tags$b("Vérification"), " : pour vérifier si la grille actuelle est correcte"
                     ),
                     tags$li(
                       tags$b("Taille"), " : pour choisir la taille de la grille (allant de 5 à 15, avec pour valeur initiale 5)"
                     ),
                     tags$li(
                       tags$b("Difficulté"), " : pour choisir la difficulté de la grille (Facile, Moyen, Difficile, avec par défaut l'option Facile)"
                     )
                   ),
                   tags$br(),
                   tags$p("Concernant l'option 'Vérification', si la grille est correcte, un message de félicitations apparaîtra. Sinon, un message d'erreur vous indiquera que votre réponse est fausse. De plus, cette option n'est pas faite pour le vérifications au milieu de la partie. Elle sert seulement à vérifier en fin de partie si vous vous êtes trompé ou non. Il est aussi important de mentionner que les cases avec des croix rouges comptent comme des cases blanches lors de la vérification."),
                   tags$br(),
                   tags$p("Il est à noter que la difficulté influe sur la proportion de cases noires dans la grille. Plus la difficulté est élevée, plus la proportion de cases noires est faible, avec pour proportions :"),
                   tags$ul(
                     tags$li(
                       tags$b("Facile"), " : 70% de cases noires"
                     ),
                     tags$li(
                       tags$b("Moyen"), " : 55% de cases noires"
                     ),
                     tags$li(
                       tags$b("Difficile"), " : 45% de cases noires"
                     )
                   ),
                   tags$br(),
                   tags$h1("A propos de nous"),
                   tags$p("Ce jeu a été réalisé dans le cadre du projet de Programmation R, une UE donnée par ",
                          tags$a(href = "https://github.com/jmm34", "Jean-Michel Marin"),
                          ", en première année de Master Statistique et Science des Données, par :"),
                   tags$ul(
                     tags$li("Camille MOTTIER (", tags$a(href = "https://github.com/cmottier", "Github"), ", ", tags$a(href = "camille.mottier@etu.umontpellier.fr", "Mail"), ")"),
                     tags$li("Guillaume BOULAND (", tags$a(href = "https://github.com/guibouland", "Github"), ", ", tags$a(href = "guillaume.bouland@etu.umontpellier.fr", "Mail"), ")")
                   )
        )
      ),
    )
  )
)




server <- function(input, output, session) {
  
  v <- reactiveValues(p=NULL, matrice=NULL, indices_lignes=NULL, indices_col=NULL, statuses=NULL, resultat=NULL)
  
  # Construction des objets réactifs
  observeEvent({
    input$new
    input$size
    input$diff},{
      # Proportion de cases noires
      v$p <- difficulte(input$diff)
      # Matrice à découvrir
      v$matrice <- matrice_alea(input$size, v$p)
      # Matrice des réponses
      v$statuses <- matrix(0, nrow = input$size, ncol = input$size)
      # Indices par lignes
      v$indices_lignes <- compteur(v$matrice,0)
      # Indices par colonnes
      v$indices_col <- t(compteur(v$matrice,1))
    })
  
  # Construction de la grille
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
          # Alignement des indices colonnes
          div(style = paste0("width: ", button_size, "px; text-align: center;"), 
              v$indices_col[i,j-coeff])
        }
        else if (i>coeff && j<=coeff) {
          # Alignement des indices lignes
          div(style = paste0("width: ", button_size, "px; text-align: center;"), 
              v$indices_lignes[i-coeff,j])
        }
        else {
          div(style = paste0("width: ", button_size, "px; text-align: center;"), " ")
        }
      })
      div(style = "display: flex; justify-content: flex-start; align-items: center;", do.call(tagList, buttons))
    })
    
    # JavaScript pour changer les couleurs des boutons et les statuts quand on les clique
    js <- "
  $('.square-button').click(function() {
    var status = parseInt($(this).data('status'));

    // On extrait les lignes et les colonnes des id des boutons
    var id = $(this).attr('id'); 
    var indices = id.split('_'); // On coupe au _
    var row = parseInt(indices[1]); // La ligne est le second élément des trois
    var col = parseInt(indices[2]); // La colonne est le dernier
    if (status === 0) {
      $(this).css('background-color', 'black');
      $(this).data('status', 1);
      Shiny.setInputValue('status_changed', {row: row, col: col, status: 1}); // On envoie le nouveau statut au server
    } else if (status === 1) {
      $(this).html('<span class=\"red-x\">X</span>');
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
    
    # On vérifie si les indices sont dans l'ensemble de la matrice de jeu
    if (!is.na(row_index) && !is.na(col_index) &&
        row_index >= 1 && row_index < (input$size+coeff) &&
        col_index >= 1 && col_index < (input$size+coeff)) {
      v$statuses[row_index, col_index] <- input$status_changed$status
    } else {
      print("Index out of bounds or invalid")
    }
  })
  
  # Paramètrage de l'effet du bouton Check
  observeEvent(input$verif,{
    # Comparaison de la matrice des réponses avec la matrice à découvrir
    res <- (replace(v$statuses, v$statuses==2, 0) == v$matrice)
    # Affichage du message 
    if (prod(res)==0) {
      showNotification("Loser !!! Essaie encore !", duration = 5, type="error")}
    else {showNotification("Bravo, c'est gagné !!!", duration = 5, type="message")}
  })
  
  # Paramétrage de l'effet du bouton Reset
  observeEvent(input$reset, {
    # On réinitialise la matrice des statuts
    v$statuses <- matrix(0, nrow = input$size, ncol = input$size)
    
    # JavaScript pour réinitialiser les couleurs des cases
    js_reset <- "
    $('.square-button').each(function() {
      $(this).css('background-color', 'white');
      $(this).html('');
      $(this).data('status', 0);
    });
  "
    session$sendCustomMessage(type = 'jsCode', message = js_reset)
  })
}

#' @title Picross
#'
#' @description picross lance une application de jeu Picross paramétrable
#'
#' @author Bouland - Mottier
#' @import shiny
#' @import shinyjs
#' @export
picross <- function() {
  shinyApp(ui = ui, server = server)
}
