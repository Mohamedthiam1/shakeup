import 'package:flutter/material.dart';
import 'dart:async';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

//la page de quiz
class _QuizPageState extends State<QuizPage> {
  int remainingTime = 30; // Temps restant initialisé à 30 secondes
  Timer? _timer; // Variable de temps

  @override
  void initState() {
    super.initState();
    startTimer(); // Démarre le compte à rebours au chargement de la page
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annule le timer pour éviter les fuites de mémoire
    super.dispose();
  }

  // Fonction pour démarrer le timer et mettre à jour le temps restant
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--; // Réduit le temps restant d'une seconde
        });
      } else {
        timer.cancel(); // Arrête le timer quand le temps atteint zéro
        // Une action peut être ajoutée ici -> passer à une autre question
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Largeur de l'écran
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: Text("Quiz",
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,

        actions: [
          // Affichage du temps restant dans l'AppBar
          Row(
            children: [
              Image.asset(
                'assets/images/icons8-time-40.png',
                width: 24,
                height: 24,
              ),

              const SizedBox(width: 4),// Espacement entre l'icône et le texte

              Text("$remainingTime s", // Affiche le temps restant en secondes
                style: TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SizedBox(
        width: width, // La largeur de la boîte s'ajuste à l'écran
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Marges autour du contenu
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: width * 0.035), // Marges horizontales dynamiques
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centrage horizontal du contenu
                children: [
                  // Ligne affichant les points
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre l'icône et le texte
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icons8-police-badge-40.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 4),
                          const Text("NB points gagnés",
                            style: TextStyle(
                              fontFamily: 'Arima',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),   //voir avec firebase pour changer la fct du nb de pnts
                        ],
                      ),

                    ],
                  ),

                  const SizedBox(height: 10),

                  // Conteneur pour afficher la question, animation ou image
                  Container(
                    margin: EdgeInsets.only(bottom: 10), // Marge inférieure
                    padding: const EdgeInsets.all(10), // Espacement interne
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Bordure noire
                      borderRadius: BorderRadius.circular(8), // Coins arrondis
                    ),
                    child: const Text(
                      "Question/animation/image",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Espacement

                  // Grille de boutons de réponse
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: const [
                      AnswerButton(text: "Réponse A", color: Colors.red),
                      AnswerButton(text: "Réponse B", color: Colors.green),
                      AnswerButton(text: "Réponse C", color: Colors.yellow),
                      AnswerButton(text: "Réponse D", color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Format de boutons de réponse
class AnswerButton extends StatelessWidget {
  final String text;
  final Color color;

  const AnswerButton({super.key, required this.text, required this.color}); // Constructeur avec paramètres requis

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Hauteur fixe du bouton
      width: 300, // Largeur fixe du bouton
      margin: EdgeInsets.only(right: 25, bottom: 20), // Marges entre les boutons
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Couleur du bouton
          side: BorderSide(color: color, width: 2), // Bordure de la même couleur que le fond
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Coins arrondis
          ),
        ),
        onPressed: () {
          // voir pour la suite : la fonction d'ajouts de points
        },
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}