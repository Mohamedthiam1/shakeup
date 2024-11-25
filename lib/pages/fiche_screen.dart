import 'package:flutter/material.dart';

class FicheScreen extends StatefulWidget {
  const FicheScreen({super.key});

  @override
  State<FicheScreen> createState() => _FicheScreenState();
}

class _FicheScreenState extends State<FicheScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fiches',
          style: TextStyle(color: Colors.black), // Texte en noir dans l'AppBar
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Couleur de fond blanche pour l'AppBar
        elevation: 0, // Supprime l'ombre de l'AppBar pour un look plus propre
        iconTheme: IconThemeData(color: Colors.black), // Icônes de l'AppBar en noir, si présentes
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouton "Avant" avec coins légèrement carrés
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, // 60% de la largeur de l'écran
              child: ElevatedButton(
                onPressed: () {
                  // Action pour "Avant"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100, // Fond du bouton en orange clair
                  foregroundColor: Colors.black, // Texte en noir
                  padding: EdgeInsets.symmetric(vertical: 15), // Hauteur ajustée
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis (valeur réduite)
                  ),
                ),
                child: Text('Avant', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 10),
            // Bouton "Pendant" avec coins légèrement carrés
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour "Pendant"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis
                  ),
                ),
                child: Text('Pendant', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 10),
            // Bouton "Après" avec coins légèrement carrés
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour "Après"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis
                  ),
                ),
                child: Text('Après', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}