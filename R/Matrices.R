matrice_alea <- function(n, p) {
  #Créer une matrice aléatoire nxn avec une proportion p de 1
  M <- matrix(0, nrow = n, ncol = n)
  nb_noir <- floor(p*n^2)
  indices <- sample(1:(n*n), nb_noir)
  M[indices] <- 1
  return(M)
}

compteur <- function(M,t) {
  #t prend la valeur 0 pour compter par ligne et 1 pour compter par colonne
  if (t==1) {M <- t(M)}
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
    res[[i]]<- ligne_i
  }
  return(res)
}
