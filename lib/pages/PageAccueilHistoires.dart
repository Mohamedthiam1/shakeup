import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'StoryPage.dart';


class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Largeur de l'écran
      height: 66, // hauteur selon ton modèle
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color:
          const Color(0xFFE6EFE3), // couleur de fond de la barre de navigation
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profil Icone
          // Trois icônes sur la gauche
          IconButton(
            icon: Image.asset(
              'assets/images/profil.png', // Remplacez par le chemin de votre image
              width: 35,
              height: 35,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFFE6EFE3), // Couleur de fond
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Effet de radius
                    ),
                    content: SizedBox(
                      width: 300, // Largeur de la boîte de dialogue
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Zone pour l'icône de profil
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                child: Image.asset(
                                  'assets/images/profil.png', // Remplacez par le chemin de votre image
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10), // Espacement
                              Container(
                                width: 215,
                                height: 45,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: Color(0xFFC7E4BF), // Couleur de fond
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x40000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  'Name/Pseudo',
                                  style: TextStyle(
                                    fontFamily: 'Arima',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    letterSpacing: -0.15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 10), // Espacement entre les éléments

                          // Zone de texte plus petite
                          Container(
                            width: 148,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFFABC9A4), // Couleur de fond
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Name/Pseudo',
                                style: TextStyle(
                                  fontFamily: 'Arima',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  letterSpacing: -0.15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 10), // Espacement entre les éléments

                          // Zone pour les photos de profils
                          Container(
                            width: 253,
                            height: 138,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFFC7E4BF), // Couleur de fond
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // Remplacez par vos images de profil
                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors
                                            .white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                                0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(
                                                0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an1.jpg', // Chemin de votre image
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit
                                              .cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors
                                            .white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                                0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(
                                                0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an2.png', // Chemin de votre image
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit
                                              .cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors
                                            .white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                                0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(
                                                0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an3.jpg', // Chemin de votre image
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit
                                              .cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors
                                            .white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                                0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(
                                                0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an4.jpg', // Chemin de votre image
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit
                                              .cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors
                                            .white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                                0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(
                                                0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an5.jpg', // Chemin de votre image
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit
                                              .cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors
                                            .white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                                0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(
                                                0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an6.png', // Chemin de votre image
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit
                                              .cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),


          IconButton(
            icon: Image.asset(
              'assets/images/badges.png',
              width: 35,
              height: 35,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.white,
                    child: SizedBox(
                      width: 402,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView( // Ajout de SingleChildScrollView pour le défilement automatique
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Trophées et badges',
                                  style: GoogleFonts.arima(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Zone pour Badges avec un Container stylisé
                              Container(
                                width: 359,
                                height: 37,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC7E4BF),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child:Text(
                                  'Badges',
                                  style: GoogleFonts.arima(
                                    fontSize: 18, // Taille du texte
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.15,
                                    color: Colors.black,
                                  ),
                                ),

                              ),
                              const SizedBox(height: 8),

                              // Badge 1
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/im1.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Expert en sécurité',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                        Text(
                                          'Description du badge pour illustrer les compétences de sécurité.',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Badge 2
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/2.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Défenseur de la nature',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                        Text(
                                          'Récompense pour les actions en faveur de la nature.',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Badge 3
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/3.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Maître de la résilience',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                        Text(
                                          'Atteint pour surmonter des défis difficiles.',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Badge 4
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/4.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Ambassadeur de la paix',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                        Text(
                                          'Remis pour les contributions à la paix.',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 45),

                              // Zone pour Badges avec un Container stylisé
                              Container(
                                width: 359,
                                height: 37,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC7E4BF),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child:Text( 'Trophées',
                                  style: GoogleFonts.arima(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Trophée 1
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/5.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Champion de la survie',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                        Text(
                                          'Gagné pour avoir terminé toutes les étapes de préparation.',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Trophée 2
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/6.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Maître des premiers soins',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                        Text(
                                          'Récompensé pour avoir appris les bases des premiers secours.',
                                          style: TextStyle(
                                            fontFamily: 'Arima',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),


          IconButton(
            icon: Image.asset(
              'assets/images/point.png',
              width: 35,
              height: 35,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Nb points'),
                    content: Text('Options de points'),
                  );
                },
              );
            },
          ),

          // Titre de l'application "ShakeUp"
          Text(
            'ShakeUp',
            style: GoogleFonts.arima(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.15,
              color: Colors.black,
            ),
          ),

          // Trois images sur la droite
          IconButton(
            icon: Image.asset(
              'assets/images/levelE.png',
              width: 45,
              height: 45,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('level'),
                    content: Text('Options de level'),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/groupe.png',
              width: 35,
              height: 35,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('groupe'),
                    content: Text('Options de groupe'),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/param.png',
              width: 35,
              height: 35,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Paramètres'),
                    content: Text('Options de réglage'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}



class ModeHistoirePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar avec le widget NavigationBar
      // appBar: AppBar(
      //   title: const NavigationBar(), // Utilisation de const NavigationBar()
      //   centerTitle: true, // Centrer le titre dans la barre
      // ),

      // Corps principal de la page
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Aligner en haut pour commencer avec le titre
          crossAxisAlignment: CrossAxisAlignment.center, // Aligner horizontalement au centre
          children: [
            // Boîte grise avec le titre centré
            Container(
              width: double.infinity,
              color: Colors.grey[300], // Couleur grise pour la boîte
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: const Center(
                child: Text(
                  'Histoires', // Titre centré
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Espace entre la boîte grise et les images

            // Row pour afficher les images horizontalement
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer les images horizontalement
              children: [
                // Image 1
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoryPage()), // Lien vers la page d'histoire
                    );
                  },
                  child: Image.asset(
                    'assets/images/histoire1.png', // Chargement de l'image depuis assets
                    width: 200, // Largeur de l'image
                    height: 200, // Hauteur de l'image
                    fit: BoxFit.cover, // Pour que l'image remplisse l'espace disponible
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ); // Icône de remplacement si l'image ne charge pas
                    },
                  ),
                ),

                // Espace entre les images
                SizedBox(width: 20), // Espace horizontal entre les images

                // Image 2
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StoryPage()), // Lien vers la page d'histoire
                      );
                    },
                  child: Image.asset(
                    'assets/images/histoire2.png', // Chargement de l'image depuis assets
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),

                // Espace entre les images
                SizedBox(width: 20), // Espace horizontal entre les images

                // Image 3
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoryPage()), // Lien vers la page d'histoire
                    );
                  },
                  child: Image.asset(
                    'assets/images/histoire3.png', // Chargement de l'image depuis assets
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(), // Footer en bas
    );
  }
}


class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      color: const Color(0xFFEBEBEB),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Image.asset(
              'assets/images/fichiers.png',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              // Naviguer vers "fiches"
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/livres.png',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              // Naviguer vers "histoire"
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD0D0D0),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: Image.asset(
                'assets/images/home.png',
                width: 35,
                height: 35,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/jeux.png',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              // Naviguer vers "mini jeux"
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/classement.png',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/classement');
            },
          ),
        ],
      ),
    );
  }
}


