#'matrice_alea crée une matrice carrée aléatoire de taille n contenant des 0 et 1, avec une proportion p de 1.
#'
#' @param n un entier
#' @param p un réel de [0,1]
#' @author Mottier
#' @examples matrice_alea(5,0.6)
#' @export
matrice_alea <- function(n, p) {
  M <- matrix(0, nrow = n, ncol = n)
  nb_noir <- floor(p*n^2)
  indices <- sample(1:(n*n), nb_noir)
  M[indices] <- 1
  return(M)
}

#'compteur calcule le nombre de 1 successifs pour chaque ligne ou chaque colonne d'une matrice carrée comportant des 1 et des 0
#'
#' @param M une matrice carrée remplie de 0 et 1
#' @param t un nombre prenant la valeur 1 pour compter par colonne
#' @author Mottier
#' @examples compteur(matrix(c(0,0,1,1,1,1,0,1,1,1,0,1,1,0,0,0),nrow=4,ncol=4,byrow=TRUE),0)
#' @export
compteur <- function(M,t) {
  sep = " "
  if (t==1) {
    M <- t(M)
    sep= "\n"}
  n <- nrow(M)
  res <- list()
  for (i in 1:n) {
    ligne_i <- c()
    compteur <- 0
    for (j in 1:n) {
      if (M[i,j]==1) {
        compteur <- compteur + 1
      }
      if ((M[i,j]==0 & compteur!=0) | (M[i,j]==1 & j==n) ) {
        ligne_i <- append(ligne_i,compteur)
        compteur <- 0}
      }
    res[[i]]<- paste(ligne_i, collapse = sep)
  }
  return(res)
}
