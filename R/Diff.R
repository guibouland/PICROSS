#' @title difficulte
#'
#' @description difficulte convertit le niveau de difficulté choisi par l'utilisateur en une proportion p de cases noires : 70\% pour le mode "Facile", 
#'55\% pour le mode "Moyen" et 45\% pour le mode "Diificile".  
#'
#' @param s chaîne de caractères parmi "Facile", "Moyen", "Difficile"
#' @author Bouland - Mottier
#' @examples 
#' difficulte("Facile")
#' @export

difficulte <- function(s) {
  if (s=='Facile') {p <- 0.7}
  if (s=='Moyen') {p <- 0.55}
  if (s=='Difficile') {p <- 0.45}
  return(p)
  }