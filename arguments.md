## Architecture

Pour ce projet, j'ai choisi l'architecture suivante :

- **Models** : Représente la structure des données pour les livres, l'authentification de l'utilisateur et les favoris.
- **Services** : Gère la communication avec l'API, la récupération des données.
- **Controllers** : Contient la logique pour gérer l'état de l'application et les interactions entre les modèles et les vues.
- **Screens** : Représente les différents écrans de l'UI où les fonctionnalités de l'app sont implémentées.
- **Widgets** : Composants réutilisables utilisés pour construire des éléments UI personnalisés tout au long de l'app.

### Pourquoi cette architecture ?

J’ai choisi d’utiliser une version légère de l’architecture MVC (Model-View-Controller) pour ce projet, car elle permet de gérer efficacement l’état des livres tout en maintenant l’application optimisée et légère. En séparant clairement la logique métier (Models et Controllers) de l'interface utilisateur (Views et Widgets), cette architecture facilite la gestion de l’état des livres, des utilisateurs, et des favoris tout en assurant une performance fluide. Cela permet également une meilleure évolutivité, tout en réduisant la complexité et la charge sur les ressources de l'application.

Les fichiers sont organisés comme suit :
- **Models** : Fichiers nommés `file_name_model.dart`
- **Controllers** : Fichiers nommés `file_name_controller.dart`
- **Services** : Fichiers nommés `file_name_service.dart`
- **Screens** : Fichiers nommés `file_name_screen.dart`
- **Util** : Ce dossier contient les couleurs primaires utilisées dans toute l’application ainsi que quelques méthodes utilitaires.

En plus du fichier `main.dart`, un fichier `routes.dart` est inclus pour gérer les routes de manière plus claire et organisée. J'ai également ajouté des commentaires dans la logique complexe des controllers pour améliorer la compréhension du code.

## Gestion de l'état

J'ai choisi **GetX** pour la gestion de l'état et voici pourquoi :

- **Pourquoi GetX ?**
  GetX est léger et très efficace. Il s'intègre parfaitement à ce petit projet, tout en permettant une gestion de l'état puissante, ainsi que la gestion de la navigation et de l'injection de dépendances. Il utilise la programmation réactive, ce qui garantit que l'état de l'application est toujours à jour sans avoir à ajouter trop de code. Ce qui en fait un choix parfait pour une application de petite taille, où la performance et la simplicité sont cruciales.

## Packages utilisés et justifications

Voici un récapitulatif des packages que j'ai utilisés et les raisons pour lesquelles je les ai choisis :

- **get**
    - **Pourquoi** : GetX simplifie la gestion de l'état et de la navigation. Il est léger et offre de bonnes performances, ce qui le rend idéal pour ce projet.

- **loading_indicator**
    - **Pourquoi** : Ce package permet d'ajouter une animation de chargement moderne et fluide pendant le processus de connexion.

- **iconsax**
    - **Pourquoi** : Iconsax offre une large variété d'icônes esthétiques et personnalisées par rapport à la bibliothèque d'icônes Material par défaut.

- **http**
    - **Pourquoi** : J'ai choisi le package `http` car il est simple, fiable et bien maintenu. Il est idéal pour effectuer des requêtes HTTP vers l'API et il s'intègre parfaitement avec Flutter.

- **shared_preferences**
    - **Pourquoi** : SharedPreferences est une solution légère et efficace pour stocker des paires clé-valeur localement. Je l'ai utilisé pour la persistance de l'authentification, en enregistrant si l'utilisateur est connecté ou non, et pour stocker les livres en cache pour un accès hors ligne.

- **flutter_native_splash**
    - **Pourquoi** : Ce package permet de créer un écran splash screen personnalisé pour l'application. Il réduit le délai avant l'affichage de l'écran principal.

- **carousel_slider**
    - **Pourquoi** : Le package carousel_slider est parfait pour créer un carrousel interactif sur la page d'accueil. Il est hautement personnalisable et offre une excellente expérience utilisateur pour afficher les livres de manière dynamique.

- **flutter_floating_bottom_bar**
    - **Pourquoi** : Ce package crée une barre de navigation flottante au bas de l'écran, ajoutant une touche moderne à l'UI et permettant une navigation facile sans encombrer l'écran principal.

- **shimmer**
    - **Pourquoi** : Le package shimmer est utilisé pour ajouter des effets modernes pendant les écrans de chargement. Cela rend l'attente plus engageante et agréable pour l'utilisateur en imitant le chargement du contenu de manière fluide.

- **url_launcher**
    - **Pourquoi** : J'ai utilisé ce package pour ouvrir des URL directement depuis l'application, ce qui permet à l'utilisateur de télécharger des livres PDF en ouvrant un navigateur. Cela ajoute une fonctionnalité essentielle pour l'app.

- **flutter_launcher_icons**
    - **Pourquoi** : Ce package permet de personnaliser l'icône de l'application.


## Bonus Fonctionnalités

Voici quelques fonctionnalités supplémentaires que j'ai ajoutées pour améliorer l'expérience utilisateur :

- **Fonction de recherche** : J'ai ajouté une fonction de recherche permettant à l'utilisateur de rechercher n'importe quel livre simplement en entrant le titre du livre. Cela facilite de trouver rapidement le contenu qu'ils recherchent.
- **Mode hors ligne** : L'application dispose désormais d'un mode hors ligne, dans lequel la liste des livres et leur contenu sont mis en cache. Cela permet aux utilisateurs d'accéder à leurs livres même en l'absence de connexion Internet.
