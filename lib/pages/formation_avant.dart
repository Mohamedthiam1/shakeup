import 'package:flutter/material.dart';

//page d'informations "Avant un Séisme"
class AvantPage extends StatelessWidget {
  const AvantPage({super.key});

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
        title: const Text("Avant un Séisme",
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

      body: const Padding(
        padding: EdgeInsets.all(16.0), // Marges autour du contenu pour un espacement uniforme
        child: SingleChildScrollView(
          // Permet le défilement si le contenu dépasse la hauteur de l'écran
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Étend les children sur toute la largeur
            children: [
              // Contenu de la page
              Text(
                "- Établissez un plan de secours familial et choisissez un lieu sûr où se rassembler après le séisme.\n"
                    "- Assurez-vous que les meubles lourds sont bien fixés aux murs.\n"
                    "- Repérez les zones sécurisées dans chaque pièce (sous des meubles solides, loin des fenêtres).\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Informez-vous des procédures d’évacuation et des numéros d’urgence.",
                style: TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}