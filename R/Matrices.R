#' @title matrice_alea
#'
#' @description matrice_alea crée une matrice carrée aléatoire de taille n contenant des 0 et 1, avec une proportion p de 1.
#'
#' @param n un entier
#' @param p un réel de [0,1]
#' @author Bouland - Mottier
#' @examples matrice_alea(5,0.6)
#' @export
matrice_alea <- function(n, p) {
  M <- matrix(0, nrow = n, ncol = n)
  nb_noir <- floor(p*n^2)
  indices <- sample(1:(n*n), nb_noir)
  M[indices] <- 1
  return(M)
}

#' @title compteur
#'
#' @description compteur calcule le nombre de 1 successifs pour chaque ligne ou chaque colonne d'une matrice carrée comportant des 1 et des 0
#'
#' @param M une matrice carrée remplie de 0 et 1
#' @param t un nombre prenant la valeur 1 pour compter par colonne
#' @author Bouland - Mottier
#' @examples compteur(matrix(c(0,0,1,1,1,1,0,1,1,1,0,1,1,0,0,0),nrow=4,ncol=4,byrow=TRUE),0)
#' @export
compteur <- function(M,t) {
  if (t==1) {
    M <- t(M)}
  nb_lignes <- nrow(M)
  nb_col <- ceiling(nb_lignes/2)
  res <- matrix(rep(" ",(nb_lignes*nb_col)), nrow = nb_lignes, ncol = nb_col)
  for (i in 1:nb_lignes) {
    ligne_i <- c()
    r <- 0
    for (j in 1:nb_lignes) {
      if (M[i,j]==1) {
        r <- r + 1
      }
      if ((M[i,j]==0 & r!=0) | (M[i,j]==1 & j==nb_lignes) ) {
        ligne_i <- append(ligne_i,r)
        r <- 0}
    }
    res[i,((nb_col-length(ligne_i)+1):nb_col)]<-ligne_i
  }
  return(res)
}




