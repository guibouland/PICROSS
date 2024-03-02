#'difficulte convertit le niveau de difficulté choisi par l'utilisateur en une proportion p de cases noires. 
#'Easy -> 0.8
#'Medium -> 0.7
#'Hard -> 0.6
#'
#' @param s chaîne de caractères parmi "Easy", "Medium", "Hard"
#' @author Bouland - Mottier
#' @examples difficulte("Easy")
#' @export

difficulte <- function(s) {
  if (s=='Easy') {p <- 0.8}
  if (s=='Medium') {p <- 0.7}
  if (s=='Hard') {p <- 0.6}
  return(p)
  }