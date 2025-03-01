import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Story2 extends StatefulWidget {
  const Story2({super.key});

  @override
  State<Story2> createState() => StoryPageContent2();
}

class StoryPageContent2 extends State<Story2> {
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Charger la langue au démarrage
  }

  // Méthode pour récupérer la langue depuis SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language'); // Vérifie s'il y a une langue sauvegardée
    if (language != null) {
      setState(() {
        selectedLanguage = language; // Met à jour la langue sélectionnée
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Ajout du Scaffold pour éviter le fond noir
        backgroundColor: Colors.white, // Fond blanc explicite
        body: SafeArea(
            child:ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Introduction à l'histoire
              Text(
                selectedLanguage == 'Français' ? 'L\'histoire de Luna la petite étoile' : 'The Story of Luna the Little Star',
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: 'Arima',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Texte et image côte à côte
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      selectedLanguage == 'Français'
                          ? 'Luna est une petite étoile qui brille dans le ciel. Une nuit, alors qu\'elle danse avec ses amies, elle ressent une vibration dans l\'espace. "Qu\'est-ce que c\'est ?", se demande-t-elle.'
                          : 'Luna is a little star shining in the sky. One night, while dancing with her friends, she feels a vibration in space. "What is that?", she wonders.',
                      style: const TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/etoile1.png',
                      height: 150,
                      fit: BoxFit.contain,  // Utilisation de BoxFit.contain
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image en premier
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 16 / 9, // Par exemple, pour un ratio 16:9
                      child: Image.asset(
                        'assets/images/etoile2.png',
                        height: 150,
                        fit: BoxFit.contain,  // Utilisation de BoxFit.contain
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Texte après l'image
                  Expanded(
                    flex: 3,
                    child: Text(
                      selectedLanguage == 'Français'
                          ? 'C\'était un tremblement de terre sur Terre ! Luna se rappelle que les humains doivent rester calmes. "Je dois les aider à se souvenir des conseils !"'
                          : 'It was an earthquake on Earth! Luna remembers that humans need to stay calm. "I must help them remember the safety tips!"',
                      style: const TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 20),

              // Texte et image pour l'abri
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      selectedLanguage == 'Français'
                          ? 'Elle commence à scintiller plus fort pour attirer l\'attention des enfants. "Cherchez un endroit sûr, restez près de vos amis !", chante-t-elle dans le ciel.'
                          : 'She starts twinkling brighter to get the children’s attention. "Find a safe place, stay close to your friends!" she sings in the sky.',
                      style: const TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/etoile3.png',
                      height: 150,
                      fit: BoxFit.contain,  // Utilisation de BoxFit.contain
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Conclusion
              Text(
                selectedLanguage == 'Français'
                    ? 'Merci d\'avoir lu cette histoire avec Luna ! Maintenant, tu sais comment réagir en cas de tremblement de terre. Ensemble, nous sommes plus forts et plus sûrs !'
                    : 'Thank you for reading this story with Luna! Now you know how to react in case of an earthquake. Together, we are stronger and safer!',
                style: const TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Retour à la page précédente
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC7E4BF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                ),
                child: Text(
                  selectedLanguage == 'Français' ? 'J\'ai compris !' : 'I understand !',
                  style: const TextStyle(
                    fontFamily: 'Arima',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}