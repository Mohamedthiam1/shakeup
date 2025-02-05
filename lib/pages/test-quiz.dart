import 'package:cap/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

import '../models/quizz.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int remainingTime = 30;
  Timer? _timer;
  List<Quizz> quizzes = [];
  int score = 0;
  bool hasReceivedFastAnswerTrophy = false;
  int currentQuestionIndex = 0;
  bool hasAnswered = false;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchRandomQuizzes();
    startTimer();
    _checkFastAnswerTrophy();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _checkFastAnswerTrophy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hasReceivedFastAnswerTrophy = prefs.getBool('fast_answer_trophy') ?? false;
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        _nextQuestion();
      }
    });
  }

  Future<void> fetchRandomQuizzes() async {
    final snapshot = await FirebaseFirestore.instance.collection("quizzes").get();
    if (snapshot.docs.isNotEmpty) {
      List<Quizz> allQuizzes = snapshot.docs
          .map((doc) => Quizz.fromJson(doc.data()))
          .toList();
      allQuizzes.shuffle(Random());
      setState(() => quizzes = allQuizzes.take(5).toList()); // Fetch 5 questions
    }
  }

  void checkAnswer(int selectedAnswer) async {
    if (hasAnswered) return; // One attempt per question

    setState(() {
      hasAnswered = true;
    });

    bool isCorrect = quizzes[currentQuestionIndex].correctOne == selectedAnswer;

    if (isCorrect) {
      setState(() {
        score += 5;
      });

      if (remainingTime >= 15 && !hasReceivedFastAnswerTrophy) {
        setState(() {
          hasReceivedFastAnswerTrophy = true;
          score += 30; // Fast answer bonus
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('fast_answer_trophy', true);
        _showTrophyPopup();
      }
    }

    _showAnswerFeedback(isCorrect);
  }

  void _showAnswerFeedback(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green : Colors.red, size: 60),
        content: Text(
          isCorrect ? "Bonne réponse !" : "Mauvaise réponse...",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); // Close feedback popup
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex + 1 < quizzes.length) {
      setState(() {
        currentQuestionIndex++;
        hasAnswered = false;
        remainingTime = 30; // Réinitialiser le temps restant
      });

      // Annuler le timer actuel et en démarrer un nouveau
      _timer?.cancel();
      startTimer(); // Redémarrer le timer avec le temps initial

      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _showQuizEndDialog();
    }
  }

  void _showQuizEndDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Quizz terminé !"),
        content: Text("Votre score final est : $score points"),
        actions: [
          TextButton(
            onPressed: () async {
              sharedPreferences!.setInt("points", sharedPreferences!.getInt("points") == null ? score : sharedPreferences!.getInt("points")! + score);
              await FirebaseFirestore.instance.collection("users").doc(sharedPreferences!.getString("uid")).update({
                "points": FieldValue.increment(score)
              });
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showTrophyPopup() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.blue, size: 40),
            SizedBox(width: 10),
            Text("Trophée Débloqué !"),
          ],
        ),
        content: const Text(
          "Félicitations ! Tu as débloqué le trophée \"Répondant Rapide\".",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InteractiveViewer(
                maxScale: 20,
                  child: Image.network(imageUrl)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quizz", style: TextStyle(fontFamily: 'Arima', fontSize: 22, color: Colors.black)),
        backgroundColor: Colors.green[100],
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset('assets/images/icons8-time-40.png', width: 24, height: 24),
                const SizedBox(width: 4),
                Text("$remainingTime s", style: const TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
      body: quizzes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          return _buildQuestionCard(quizzes[index]);
        },
      ),
    );
  }

  Widget _buildQuestionCard(Quizz quiz) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Score: $score",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  ElevatedButton(
                    onPressed: _showQuizEndDialog,  // Appeler une méthode pour finir le quiz
                    child: const Text("Terminer",
                        style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,  // Couleur du bouton
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (quiz.pictureUrl != null && quiz.pictureUrl!.isNotEmpty)
              GestureDetector(
                onTap: () => _showImageDialog(quiz.pictureUrl!),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(quiz.pictureUrl!, fit: BoxFit.cover),
                  ),
                ),
              ),
            Text(quiz.question ?? "Question introuvable",
                textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            const SizedBox(height: 10),
            ...List.generate(
              quiz.answers!.length,
                  (i) => AnswerButton(
                text: quiz.answers![i],
                onPressed: () => checkAnswer(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AnswerButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}