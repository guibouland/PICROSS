# Projet de simulation d'un jeu de Picross

Création d'une application shiny simulant un jeu de Picross.

La grille est paramétrable en fonction de la taille et de la difficulté souhaitée.

## Utilisation 

Pour installer le package et lancer le jeu : 

```{}
install.packages("devtools")
devtools::install_github("guibouland/Picross")
Picross::picross()
```

## Interactivité de l'application

Grille de boutons cliquables : case blanche (non répondue), case noire (case cachant un élément à découvrir), case cochée (case ne contenant pas d'élément à découvrir)

Nouveau : génère une nouvelle grille

Réinitialiser : remet à zéro la grille en cours

Taille : permet de sélectionner la taille de la grille

Difficulté : permet de sélectionner la difficulté de la grille

Vérification : permet de vérifier sa réponse

## Auteurs

- Guillaume BOULAND : [guillaume.bouland@etu.umontpellier.fr](mailto:guillaume.bouland@etu.umontpellier.fr),
- Camille MOTTIER : [camille.mottier@etu.umontpellier.fr](mailto:camille.mottier@etu.umontpellier.fr).
