import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class After_Screen extends StatefulWidget {
  const After_Screen({super.key});

  @override
  State<After_Screen> createState() => _After_ScreenState();
}

class _After_ScreenState extends State<After_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Précautions Avant un Séisme"),
        backgroundColor: Colors.green[300],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Précautions à prendre avant un séisme",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
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
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
