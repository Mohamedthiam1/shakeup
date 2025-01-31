import 'package:cap/pages/after_screen.dart';
import 'package:cap/pages/formation_avant.dart';
import 'package:cap/pages/pendant_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';


class FicheScreen extends StatefulWidget {
  const FicheScreen({super.key});

  @override
  State<FicheScreen> createState() => _FicheScreenState();
}

class _FicheScreenState extends State<FicheScreen> {
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Charger la langue au démarrage
  }

  // Charger la langue depuis SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language');
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

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
        title: Text(selectedLanguage == 'Français' ? 'Fiches' : 'Cards',
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
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AvantPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6DFC5), // Fond du bouton en orange clair
                  foregroundColor: Colors.black, // Texte en noir
                  padding: EdgeInsets.symmetric(vertical: 15), // Hauteur ajustée
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis (valeur réduite)
                  ),
                ),
                child: Text(selectedLanguage == 'Français' ? 'Avant' : 'Before',
                  style: TextStyle(
                    fontFamily: 'Arima',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Bouton "Pendant" avec coins légèrement carrés
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour "Pendant"
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PendantScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6DFC5),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis
                  ),
                ),
                child: Text(selectedLanguage == 'Français' ? 'Pendant' : 'During',
                  style: TextStyle(
                    fontFamily: 'Arima',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Bouton "Après" avec coins légèrement carrés
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour "Après"
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => After_Screen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6DFC5),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis
                  ),
                ),
                child: Text(selectedLanguage == 'Français' ? 'Après' : 'After',
                  style: TextStyle(
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
      ),
      bottomNavigationBar: const Footer(), // Footer en bas
    );
  }
}