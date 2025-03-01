import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KitDeSurviePage extends StatefulWidget {
  const KitDeSurviePage({super.key});

  @override
  State<KitDeSurviePage> createState() => _KitDeSurviePageState();
}

class _KitDeSurviePageState extends State<KitDeSurviePage> {
  int currentIndex = 0;
  bool isCorrect = false;
  String? selectedImageUrl;
  String? explanation; // Explication dynamique en fonction de l'image
  final AudioPlayer _audioPlayer = AudioPlayer();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedLanguage == 'Français' ? "Kit de survie" : "Survival kit",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("kit_de_survie").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Aucune donnée disponible."));
            }

            final data = snapshot.data!.docs;
            if (currentIndex >= data.length) {
              return _buildFinalCelebration();
            }

            final currentDocument = data[currentIndex].data() as Map<String, dynamic>;
            final String image1Url = currentDocument["image1Url"] ?? "";
            final String image2Url = currentDocument["image2Url"] ?? "";
            final String image3Url = currentDocument["image3Url"] ?? "";
            final String correctAnswerUrl = currentDocument["correctAnswer"] ?? "";
            final String explanation1 = currentDocument["explanation1"] ?? "";
            final String explanation2 = currentDocument["explanation2"] ?? "";
            final String explanation3 = currentDocument["explanation3"] ?? "";

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    selectedLanguage == 'Français'
                        ? "Cliquez sur l'image qui montre le bon comportement 👇"
                        : "Click on the image that shows the correct behavior 👇",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildImageOption(image1Url, correctAnswerUrl, explanation1),
                      _buildImageOption(image2Url, correctAnswerUrl, explanation2),
                      _buildImageOption(image3Url, correctAnswerUrl, explanation3),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageOption(String imageUrl, String correctAnswerUrl, String explanation) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImageUrl = imageUrl;
          isCorrect = imageUrl == correctAnswerUrl;
          this.explanation = explanation; // Assigner l'explication correcte selon l'image
        });
        _playSound(isCorrect);
        _showResultDialog(context);
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedImageUrl == imageUrl
                ? (isCorrect ? Colors.green : Colors.red)
                : Colors.transparent,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  void _playSound(bool correct) {
    String soundFile = correct ? "sounds/correct.mp3" : "sounds/wrong.mp3";
    _audioPlayer.play(AssetSource(soundFile));
  }

  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green[100] : Colors.red[100],
          title: Text(
            isCorrect
                ? (selectedLanguage == 'Français' ? "Bonne réponse ! 🎉" : "Correct answer ! 🎉")
                : (selectedLanguage == 'Français' ? "Mauvaise réponse 😞" : "Wrong answer 😞"),
            textAlign: TextAlign.center,
            style: TextStyle(color: isCorrect ? Colors.green[800] : Colors.red[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isCorrect
                    ? (selectedLanguage == 'Français' ? "Bravo ! C'est le bon comportement ! 🎉" : "Well done ! That's the right behavior ! 🎉")
                    : (selectedLanguage == 'Français' ? "Oups ! Ce n'est pas le bon comportement. 😞" : "Oops! That's not the right behavior. 😞"),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                explanation ?? (selectedLanguage == 'Français' ? "Pas d'explication disponible." : "No explanation available."),
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isCorrect) {
                  setState(() {
                    currentIndex++;
                    selectedImageUrl = null;
                  });
                } else {
                  setState(() {
                    selectedImageUrl = null;
                  });
                }
              },
              child: const Text("OK", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFinalCelebration() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(selectedLanguage == 'Français' ? "🎉 Félicitations ! Vous avez appris à utiliser le kit de survie ! 🎉" : "🎉 Congratulations! You have learned how to use the survival kit! 🎉",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }
}
