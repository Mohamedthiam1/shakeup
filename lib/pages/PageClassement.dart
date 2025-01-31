import 'package:flutter/material.dart';
import 'home_page.dart';

class ClassementPage extends StatelessWidget {
  final List<Map<String, dynamic>> enfants = [
    {'nom': 'Alice', 'score': 95, 'avatar': 'assets/images/profil.png'},
    {'nom': 'Bob', 'score': 88, 'avatar': 'assets/images/profil.png'},
    {'nom': 'Clara', 'score': 82, 'avatar': 'assets/images/profil.png'},
    {'nom': 'David', 'score': 75, 'avatar': 'assets/images/profil.png'},
    // Ajoute d'autres enfants avec leur score ici
  ];

  ClassementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de flèche
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text("Classement",
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100], // Couleur de fond verte pour l'AppBar
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const NavigationBar(), // Affiche la NavigationBar en haut de la page

          const SizedBox(height: 2), // Espace entre la boîte grise et la liste

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
                      width: 380,  // Largeur fixe pour chaque boîte (taille petite)
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6DFC5), // Couleur crevette pour la boîte
                        borderRadius: BorderRadius.circular(12), // Coins arrondis
                        boxShadow: [
                          const BoxShadow(
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
                                fontFamily: 'Arima',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          // Score
                          Text(
                            '${enfant['score']} points',
                            style: TextStyle(
                              fontSize: 14,  // Taille réduite pour le score
                              fontFamily: 'Arima',
                              fontWeight: FontWeight.w400,
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


