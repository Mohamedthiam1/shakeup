import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

class TrouverAbriPage extends StatefulWidget {
  const TrouverAbriPage({super.key});

  @override
  State<TrouverAbriPage> createState() => _TrouverAbriPageState();
}

class _TrouverAbriPageState extends State<TrouverAbriPage> {
  int currentIndex = 0;
  bool isCorrect = false;
  String? selectedAnswer;
  bool showCelebration = false;

  final AudioPlayer _audioPlayer = AudioPlayer(); // Lecteur audio

  final Map<String, Color> defaultColors = {
    '1': Colors.purple[200]!,
    '2': Colors.blue[200]!,
    '3': Colors.orange[200]!,
    '4': Colors.green[200]!,
  };

  final Map<String, Color> selectedColors = {
    'correct': Colors.green[400]!,
    'wrong': Colors.red[400]!,
  };

  // Fonction pour jouer un son
  void _playSound(String soundPath) async {
    await _audioPlayer.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trouver l’Abri",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("trouver_abri").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Aucune donnée disponible pour le moment."));
            }

            final data = snapshot.data!.docs;
            if (currentIndex >= data.length) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "🎊 Félicitations ! Vous avez trouvé tous les abris ! 🎊",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            }

            final currentDocument = data[currentIndex];
            final imageUrl = currentDocument["imageUrl"];
            final correctAnswer = currentDocument["correctAnswer"];

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "🏠 Cliquez sur le numéro de l'abri 🏠",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double boxWidth = constraints.maxWidth * 0.4;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildOptionBox(context, '1', correctAnswer, boxWidth),
                                    _buildOptionBox(context, '2', correctAnswer, boxWidth),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildOptionBox(context, '3', correctAnswer, boxWidth),
                                    _buildOptionBox(context, '4', correctAnswer, boxWidth),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOptionBox(BuildContext context, String text, String correctAnswer, double width) {
    Color boxColor = defaultColors[text]!;

    if (selectedAnswer == text) {
      boxColor = isCorrect ? selectedColors['correct']! : selectedColors['wrong']!;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = text;
          isCorrect = text == correctAnswer;
        });

        // Jouer le son selon la réponse
        if (isCorrect) {
          _playSound("sounds/correct.mp3");
        } else {
          _playSound("sounds/wrong.mp3");
        }

        _showResultDialog(context);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: width,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green[100] : Colors.red[100],
          title: Text(
            isCorrect ? "Bonne réponse ! 🎉" : "Mauvaise réponse 😞",
            textAlign: TextAlign.center,
            style: TextStyle(color: isCorrect ? Colors.green[800] : Colors.red[800]),
          ),
          content: Text(
            isCorrect ? "Félicitations, vous avez trouvé le bon abri ! 🏆" : "Réessayez pour trouver le bon abri. 💪",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isCorrect) {
                  setState(() {
                    currentIndex++;
                    selectedAnswer = null;
                  });
                } else {
                  setState(() {
                    selectedAnswer = null;
                  });
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}

