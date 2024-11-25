import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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


class ClassementPage extends StatelessWidget {
  final List<Map<String, dynamic>> enfants = [
    {'nom': 'Alice', 'score': 95, 'avatar': 'assets/images/profil.png'},
    {'nom': 'Bob', 'score': 88, 'avatar': 'assets/images/profil.png'},
    {'nom': 'Clara', 'score': 82, 'avatar': 'assets/images/profil.png'},
    {'nom': 'David', 'score': 75, 'avatar': 'assets/images/profil.png'},
    // Ajoute d'autres enfants avec leur score ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const NavigationBar(), // Affiche la NavigationBar en haut de la page

          // Boîte grise avec le titre centré
          Container(
            width: double.infinity,
            color: Colors.grey[300], // Couleur grise pour la boîte
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: const Center(
              child: Text(
                'Classement',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // Espace entre la boîte grise et la liste

          // Liste des enfants avec leur score
          Expanded(
            child: ListView.builder(
              itemCount: enfants.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> enfant = enfants[index];

                // Couleur de médaille en fonction du rang
                Color medailleColor;
                if (index == 0) {
                  medailleColor = Colors.amber[700]!; // Or
                } else if (index == 1) {
                  medailleColor = Colors.grey; // Argent
                } else if (index == 2) {
                  medailleColor = Colors.brown[400]!; // Bronze
                } else {
                  medailleColor = Colors.blueGrey; // Participation
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(  // Centre chaque boîte de classement sur l'écran
                    child: Container(
                      width: 280,  // Largeur fixe pour chaque boîte (taille petite)
                      decoration: BoxDecoration(
                        color: Colors.orange[100], // Couleur crevette pour la boîte
                        borderRadius: BorderRadius.circular(12), // Coins arrondis
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Médaille
                          Icon(
                            Icons.star,
                            color: medailleColor,
                            size: 24,  // Taille de la médaille
                          ),
                          const SizedBox(width: 12), // Espacement entre la médaille et l'avatar

                          // Avatar (image)
                          ClipOval(  // Utiliser ClipOval pour faire une forme circulaire
                            child: Image.asset(
                              enfant['avatar'],  // Chemin de l'image de l'avatar
                              width: 40,  // Largeur de l'avatar
                              height: 40,  // Hauteur de l'avatar
                              fit: BoxFit.cover,  // S'adapte à la forme circulaire
                            ),
                          ),
                          const SizedBox(width: 12), // Espacement entre l'avatar et le nom

                          // Nom et prénom
                          Expanded(
                            child: Text(
                              enfant['nom'],
                              style: const TextStyle(
                                fontSize: 16,  // Taille de police réduite
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Score
                          Text(
                            '${enfant['score']} points',
                            style: TextStyle(
                              fontSize: 14,  // Taille réduite pour le score
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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

