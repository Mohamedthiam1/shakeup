import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DangerPage extends StatefulWidget {
  const DangerPage({super.key});

  @override
  State<DangerPage> createState() => _DangerPageState();
}

class _DangerPageState extends State<DangerPage> {
  int currentIndex = 0;
  bool isCorrect = false;
  String? selectedAnswer;
  bool showCelebration = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Éviter les Dangers",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("evite_les_dangers").snapshots(),
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

            final currentDocument = data[currentIndex];

            // Caster les données Firestore en Map<String, dynamic>
            final Map<String, dynamic>? documentData = currentDocument.data() as Map<String, dynamic>?;

            if (documentData == null || !documentData.containsKey("correctAnswer")) {
              return const Center(
                child: Text(
                  "⚠️ Erreur : Champ 'correctAnswer' manquant dans Firestore.",
                  style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            final imageUrl = documentData["imageUrl"] ?? "";
            final correctAnswer = documentData["correctAnswer"] ?? "0";

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
                            "⚠️ Cliquez sur la réponse correcte ⚠️",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
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
                if (showCelebration) const AnimatedCelebration(),
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
          showCelebration = isCorrect;
        });
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

  // 🔥 Ajout de la méthode manquante _showResultDialog
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
            isCorrect
                ? "Bravo, vous avez trouvé la bonne réponse ! 🎉"
                : "Essayez encore ! 😞",
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
                    showCelebration = false;
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

  Widget _buildFinalCelebration() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("🎉 Félicitations ! Vous avez réussi ! 🎉",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
          SizedBox(height: 20),
          AnimatedCelebration(),
        ],
      ),
    );
  }
}

// Animation de célébration
class AnimatedCelebration extends StatelessWidget {
  const AnimatedCelebration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("🎊", style: TextStyle(fontSize: 40)),
          SizedBox(height: 10),
          Text("🏆", style: TextStyle(fontSize: 40)),
          SizedBox(height: 10),
          Text("🎯", style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}
