#' @title difficulte
#'
#' @description difficulte convertit le niveau de difficulté choisi par l'utilisateur en une proportion p de cases noires : 70\% pour le mode "Easy", 
#'55\% pour le mode "Medium" et 45\% pour le mode "Hard".  
#'
#' @param s chaîne de caractères parmi "Easy", "Medium", "Hard"
#' @author Bouland - Mottier
#' @examples 
#' difficulte("Easy")
#' @export

difficulte <- function(s) {
  if (s=='Easy') {p <- 0.7}
  if (s=='Medium') {p <- 0.55}
  if (s=='Hard') {p <- 0.45}
  return(p)
  }