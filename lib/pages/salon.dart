import 'package:cap/pages/test-quiz.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

// Page pour gérer les salons : création ou connexion
class SalonPage extends StatelessWidget {
  const SalonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: Text('Salons', // Titre affiché dans la barre d'application
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100], // Couleur de fond verte claire
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrage vertical des cadres (au milieu de la page)
          children: [
            // Bouton "Créer un salon"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, // 60% de la largeur de l'écran
              child: SalonButton(
                title: 'Créer un salon',
                onPressed: () => showCreateSalonDialog(context),
              ),
            ),

            SizedBox(height: 10), // Espacement entre les deux cadres

            // Bouton "Rejoindre un salon"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, // 60% de la largeur de l'écran
              child : SalonButton(
                title: 'Rejoindre un salon',
                onPressed: () => showJoinSalonDialog(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(), // Footer en bas
    );
  }

  // Popup pour créer un salon (demande nom professeur et niveau de difficulté)
  void showCreateSalonDialog(BuildContext context) {
    final TextEditingController professorController = TextEditingController(); // Boîte pour récupérer le nom du professeur
    String selectedDifficulty = '1'; // Niveau de difficulté par défaut

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Créer un salon'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Champ de texte pour le nom du professeur
                  TextField(
                    controller: professorController,
                    decoration: const InputDecoration(
                      labelText: 'Nom du professeur',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16), // Espacement
                  // Dropdown pour sélectionner la difficulté
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Niveau de difficulté :',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton<String>(
                        value: selectedDifficulty,
                        items: ['1', '2', '3'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedDifficulty = newValue; //initialisation selon la nouvelle valeur
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                // Bouton Annuler
                TextButton(
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Ferme le popup
                  },
                ),
                // Bouton Créer
                TextButton(
                  child: const Text('Créer'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Ferme le popup
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ParticipantsPage(
                          roomNumber: 'Nouvelle Salle', // Nom de salle par défaut
                          professorName: professorController.text,
                          difficulty: selectedDifficulty,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Popup pour rejoindre un salon (bouton rejoindre) : demande le numéro de salle
  void showJoinSalonDialog(BuildContext context) {
    final TextEditingController roomController = TextEditingController(); // Boîte pour récupérer le numéro de la salle

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rejoindre un salon'), // Titre du popup
          content: TextField(
            controller: roomController, // Champ de texte pour entrer le numéro de salle
            decoration: const InputDecoration(
              labelText: 'Numéro de sallon', // Libellé au fond du cadre
              border: OutlineInputBorder(), // Style de la bordure
            ),
            keyboardType: TextInputType.number, // Affiche un clavier numérique
          ),
          actions: [
            // Bouton Annuler : ferme le popup
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le popup
              },
            ),
            // Bouton Rejoindre : redirige vers la page des participants en attente
            TextButton(
              child: const Text('Rejoindre'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le popup
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ParticipantsPage(
                      roomNumber: roomController.text, // Affiche le numéro de salle saisi
                      professorName: '', //doit afficher le nom du professeur depuis la base de donnée d'après le numéro de salle
                      difficulty:'',
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// Cadres boutons pour "Créer un salon" and "Rejoindre un salon"
class SalonButton extends StatelessWidget {
  final String title; // Titre du bouton
  final VoidCallback onPressed; // Action au clic

  const SalonButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF2D2B1), // Couleur de fond rose-orange
        padding: const EdgeInsets.symmetric(vertical: 15), // Espacement interne
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Coins arrondis
          side: const BorderSide(color: Colors.black), // Bordure noire
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Page des participants en attente
class ParticipantsPage extends StatelessWidget {
  final String roomNumber;
  final String professorName;

  const ParticipantsPage({super.key, required this.roomNumber, required this.professorName, required String difficulty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text("Participants", // Titre de la page
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // En-tête avec le nom du professeur et le numéro de salle
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nom du professeur',
                    style: TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'N° de salle',
                    style: TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(professorName), // Affiche le nom du professeur
                  Text(roomNumber), // Affiche le numéro de la salle
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Liste des participants
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Participants :',
                      style: TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),

                    Text("Aucun participant trouvé pour cette salle."),

                    SizedBox(height: 70),

                    // Bouton "Start" pour démarrer le quiz
                    Align(
                      alignment: Alignment.bottomRight, // Bouton placé en bas à droite
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => QuizPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF6DFC5), // Couleur de fond
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(color: Colors.black, width: 1), // Bord noir
                          ),
                          minimumSize: const Size(60, 30), // Taille du bouton
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        ),
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Arima',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}