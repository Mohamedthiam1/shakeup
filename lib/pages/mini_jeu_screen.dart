import 'package:cap/pages/KitDeSurvie.dart';
import 'package:cap/pages/evite%20les%20danger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TrouverAbriPage.dart';
import 'home_page.dart';


class MiniJeuScreen extends StatefulWidget {
  const MiniJeuScreen({super.key});

  @override
  State<MiniJeuScreen> createState() => _MiniJeuScreenState();
}

class _MiniJeuScreenState extends State<MiniJeuScreen> {
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Charger la langue au démarrage
  }

  // Récupérer la langue enregistrée
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: Text(selectedLanguage == 'Français' ? "Mini jeux" : "Mini games",
          style: const TextStyle(
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TrouverAbriPage()));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.22, // 22% de la largeur de l'écran
                      child: Image.asset('assets/images/img5.jpg'),
                    ),
                  ),
                  Text(
                    selectedLanguage == 'Français' ? "Trouver l’abri" : "Find the shelter",
                    style: const TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const KitDeSurviePage()));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.22, // 22% de la largeur de l'écran
                      child: Image.asset('assets/images/img4.jpg'),
                    ),
                  ),
                  Text(
                    selectedLanguage == 'Français' ? "Kit de survie" : "Survival kit",
                    style: const TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const DangerPage()));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.22, // 22% de la largeur de l'écran
                      child: Image.asset('assets/images/img3.jpg'),
                    ),
                  ),
                  Text(
                    selectedLanguage == 'Français' ? "Éviter les dangers" : "Avoid the dangers",
                    style: const TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(), // Footer en bas
    );
  }
}