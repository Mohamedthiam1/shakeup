import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

class DangerPage extends StatefulWidget {
  const DangerPage({super.key});

  @override
  State<DangerPage> createState() => _DangerPageState();
}

class _DangerPageState extends State<DangerPage> {
  int currentIndex = 0;
  bool isCorrect = false;
  String? selectedImageUrl;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Éviter les Dangers",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("danger").snapshots(),
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

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30), // 🔽 Descend les images un peu plus bas
                  const Text(
                    "Cliquez sur l'image qui montre le bon comportement 👇",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30), // 🔽 Ajoute un espace avant les images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildImageOption(image1Url, correctAnswerUrl),
                      _buildImageOption(image2Url, correctAnswerUrl),
                      _buildImageOption(image3Url, correctAnswerUrl),
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

  Widget _buildImageOption(String imageUrl, String correctAnswerUrl) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImageUrl = imageUrl;
          isCorrect = imageUrl == correctAnswerUrl;
        });
        _playSound(isCorrect);
        _showResultDialog(context);
      },
      child: Container(
        width: 150, // 🔍 Agrandi l'image
        height: 150, // 🔍 Agrandi l'image
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedImageUrl == imageUrl
                ? (isCorrect ? Colors.green : Colors.red)
                : Colors.transparent,
            width: 4, // 🔍 Épaisit le contour quand une image est sélectionnée
          ),
          borderRadius: BorderRadius.circular(15), // 🔍 Arrondi les bords un peu plus
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
            isCorrect ? "Bonne Réponse !" : "Mauvaise Réponse",
            textAlign: TextAlign.center,
            style: TextStyle(color: isCorrect ? Colors.green[800] : Colors.red[800]),
          ),
          content: Text(
            isCorrect ? "Bravo ! C'est le bon comportement ! 🎉" : "Oups ! Ce n'est pas le bon comportement. 😞",
            textAlign: TextAlign.center,
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("🎉 Félicitations ! Vous avez appris à éviter les dangers ! 🎉",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }
}
