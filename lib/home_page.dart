import 'package:cap/pages/fiche_screen.dart';
import 'package:cap/pages/mini_jeu_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AdminQuizPage.dart';
import 'StoryPage.dart';
import 'TrouverAbriPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: HomePageContent(),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          NavigationBar(),
          Expanded(
            child: CenterContent(),
          ),
          Footer(),
        ],
      ),
    );
  }
}

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
                                            color: Color(0x40000000), // Couleur de l'ombre
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
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC7E4BF),
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
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC7E4BF),
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
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                  return AlertDialog(
                    backgroundColor: Colors.transparent, // Boîte principale transparente
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    content: SizedBox(
                      width: 350,
                      height: 420,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Niveau 1
                          Container(
                            width: 340,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 8), // Espacement entre les niveaux
                            decoration: const BoxDecoration(
                              color: Color(0xFFC7E4BF), // Couleur de fond pour chaque niveau
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Niveau 1',
                                  style: GoogleFonts.arima(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16), // Margin left et right
                                  child: Text(
                                    'Apprendre les bases de la préparation avant un séisme',
                                    textAlign: TextAlign.center, // Aligner le texte au centre
                                    style: GoogleFonts.arima(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: -0.15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Niveau 2
                          Container(
                            width: 340,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 8), // Espacement entre les niveaux
                            decoration: const BoxDecoration(
                              color: Color(0xFFC7E4BF), // Couleur de fond pour chaque niveau
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Niveau 2',
                                  style: GoogleFonts.arima(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16), // Margin left et right
                                  child: Text(
                                    'Réagir rapidement et efficacement pendant un tremblement de terre',
                                    textAlign: TextAlign.center, // Aligner le texte au centre
                                    style: GoogleFonts.arima(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: -0.15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Niveau 3
                          Container(
                            width: 340,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC7E4BF), // Couleur de fond pour chaque niveau
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Niveau 3',
                                  style: GoogleFonts.arima(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16), // Margin left et right
                                  child: Text(
                                    'Sécuriser l\'environnement et éviter les dangers après un séisme.',
                                    textAlign: TextAlign.center, // Aligner le texte au centre
                                    style: GoogleFonts.arima(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: -0.15,
                                    ),
                                  ),
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

class CenterContent extends StatelessWidget {
  const CenterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/images/a6860f25455cb323bd70ffc082b3d8cd.jpg',
        ),
        ElevatedButton(
          onPressed: () {
            // Action pour le bouton start
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF6DFC5), // Couleur de fond
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), // Arrondi supérieur gauche
                topRight: Radius.circular(5), // Pas d'arrondi supérieur droit
                bottomRight:
                    Radius.circular(5), // Pas d'arrondi inférieur droit
                bottomLeft:
                    Radius.circular(5), // Pas d'arrondi inférieur gauche
              ),
              side: BorderSide(color: Colors.black, width: 1), // Bord noir
            ),
            minimumSize: const Size(88, 46), // Taille du bouton
          ),
          child: Text(
            'Start',
            style: GoogleFonts.arima(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.15,
              color: Colors.black,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft:
                Radius.circular(25.0), // Ajustez la valeur selon votre besoin
            bottomRight: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
            topLeft:
                Radius.circular(25.0), // Ajustez la valeur selon votre besoin
          ),
          child: Image.asset(
            'assets/images/78219b52fdfaa70af0862fb0fdb88046.jpg',
            height: 220,
          ),
        ),
      ],
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
          // Image pour "Fiches"
          IconButton(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/fichiers.png',
                width: 40, // Ajustez la taille
                height: 40,
              ),
            ),
            onPressed: () {
              // Naviguer vers "fiches"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FicheScreen()), // Lien vers la page d'histoire
              );
            },
          ),

// Image pour "Histoire"
          IconButton(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/livres.png',
                width: 40,
                height: 40,
              ),
            ),
            onPressed: () {
              // Naviguer vers la page d'histoire
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoryPage()), // Lien vers la page d'histoire
              );
            },
          ),


          // Conteneur pour l'image de "Accueil" avec un arrière-plan plus foncé
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD0D0D0), // Couleur de fond plus foncée
              borderRadius: BorderRadius.circular(10), // Effet de bord arrondi
            ),
            padding: const EdgeInsets.all(8), // Espace autour de l'image
            child: IconButton(
              icon: Image.asset(
                'assets/images/home.png',
                width: 35,
                height: 35,
              ),
              onPressed: () {
                // Rester dans la page d'accueil
              },
            ),
          ),

          // Image pour "Mini Jeux"
          IconButton(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/jeux.png',
                width: 40,
                height: 40,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MiniJeuScreen()),
              );
            },
          ),


          // Image pour "Classement"
          IconButton(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/classement.png',
                width: 40,
                height: 40,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminQuizPage()),
              );
            },
          ),

        ],
      ),
    );
  }
}
