import 'package:flutter/material.dart';

class TrouverAbriPage extends StatelessWidget {
  const TrouverAbriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trouver l’Abri',
          style: TextStyle(fontFamily: 'Arima', fontSize: 20),
        ),
        backgroundColor: const Color(0xFFABC9A4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image contenant les chiffres avec bordure
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.teal, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/numabri.jpg',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,  // Utilisation de BoxFit.cover pour couvrir le cadre
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Propositions de réponse avec "boxes"
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Première ligne de réponses
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildOptionBox(context, '12'),
                        _buildOptionBox(context, '34'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Deuxième ligne de réponses
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildOptionBox(context, '56'),
                        _buildOptionBox(context, '78'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour une boîte de réponse (option avec bordure)
  Widget _buildOptionBox(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        // Logique pour vérifier la réponse
        bool isCorrect = text == '34'; // Exemple : '34' est la bonne réponse
        _showResultDialog(context, isCorrect);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[50], // Changer la couleur de fond en teal clair
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20), // Augmenter le padding pour rendre les boutons plus larges
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Dialog pour afficher le résultat
  void _showResultDialog(BuildContext context, bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFE6EFE3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            isCorrect ? 'Bonne Réponse !' : 'Mauvaise Réponse',
            style: const TextStyle(fontFamily: 'Arima', fontSize: 20),
            textAlign: TextAlign.center,
          ),
          content: Text(
            isCorrect
                ? 'Félicitations, vous avez trouvé le bon abri !'
                : 'Réessayez pour trouver le bon abri.',
            style: const TextStyle(fontFamily: 'Arima', fontSize: 16),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
