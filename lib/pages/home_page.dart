import 'package:cap/pages/PageAccueilHistoires.dart';
import 'package:cap/pages/PageClassement.dart';
import 'package:cap/pages/fiche_screen.dart';
import 'package:cap/pages/mini_jeu_screen.dart';
import 'package:cap/pages/reglages.dart';
import 'package:cap/pages/salon.dart';
import 'package:cap/pages/test-quiz.dart';
import 'package:cap/pages/trophee_screen.dart';
import 'package:flutter/material.dart';


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
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width, // Largeur de l'écran
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
              'assets/images/profil.png',
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
                                  'assets/images/profil.png',
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
                          const SizedBox(height: 10), // Espacement entre les éléments

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
                          const SizedBox(height: 10), // Espacement entre les éléments

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
                                        color: Colors.white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an1.jpg',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors.white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an2.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors.white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an3.jpg',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover, // Ajustement de l'image
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
                                        color: Colors.white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an4.jpg',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors.white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an5.jpg',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover, // Ajustement de l'image
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 60, // Largeur du conteneur
                                      height: 60, // Hauteur du conteneur
                                      decoration: const BoxDecoration(
                                        shape:
                                            BoxShape.circle, // Forme circulaire
                                        color: Colors.white, // Couleur de fond blanche
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x40000000), // Couleur de l'ombre
                                            blurRadius: 4, // Flou de l'ombre
                                            offset: Offset(0, 2), // Décalage de l'ombre
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/an6.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover, // Ajustement de l'image
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TropheeScreen()));
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
                    title: Text('Nb points',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Arima',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    content: Text('Options de points',
                      style: TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Titre de l'application "ShakeUp"
          Text(
            'ShakeUp',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.15,
              color: Colors.black,
              fontFamily: 'Arima',
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
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Arima',
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
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Arima',
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
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Arima',
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
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Arima',
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
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Arima',
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
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Arima',
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SalonPage()));
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/param.png',
              width: 35,
              height: 35,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SettingsPage()));
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
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QuizPage()));
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
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Arima',
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
                width: 50, // Ajustez la taille
                height: 50,
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
                width: 50,
                height: 50,
              ),
            ),
            onPressed: () {
              // Naviguer vers la page d'histoire
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModeHistoirePage()), // Lien vers la page d'histoire
              );
            },
          ),


          // Conteneur pour l'image de "Accueil" avec un arrière-plan plus foncé
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9), // Couleur de fond plus foncée
              borderRadius: BorderRadius.circular(10), // Effet de bord arrondi
            ),
            padding: const EdgeInsets.all(12), // Espace autour de l'image
            child: IconButton(
              icon: Image.asset(
                'assets/images/home.png',
                width: 45,
                height: 45,
              ),
              onPressed: () {
                // Rester dans la page d'accueil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // Lien vers la page d'histoire
                );
              },
            ),
          ),

          // Image pour "Mini Jeux"
          IconButton(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/jeux.png',
                width: 50,
                height: 50,
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
                width: 50,
                height: 50,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClassementPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
