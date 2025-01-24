import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchRandomQuizzes();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  // Fonction pour récupérer 2 quizz aléatoires
  Future<void> fetchRandomQuizzes() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection("quizzes").get();

    if (snapshot.docs.isNotEmpty) {
      List<Quizz> allQuizzes = snapshot.docs
          .map((doc) => Quizz.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allQuizzes.shuffle(Random());
      setState(() {
        quizzes = allQuizzes.take(2).toList();
      });
    }
  }

  void checkAnswer(int questionIndex, int selectedAnswer) {
    if (quizzes[questionIndex].correctOne == selectedAnswer) {
      setState(() {
        score += 5; // +5 points si la réponse est correcte
      });
    }

    // Passer à la question suivante
    if (questionIndex + 1 < quizzes.length) {
      setState(() {});
    } else {
      // Afficher un message de fin
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Quiz terminé !"),
          content: Text("Votre score final est : $score points"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Quiz",
            style: TextStyle(fontFamily: 'Arima', fontSize: 22, color: Colors.black)),
        backgroundColor: Colors.green[100],
        centerTitle: true,
        actions: [
          Row(
            children: [
              Image.asset(
                'assets/images/icons8-time-40.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 4),
              Text("$remainingTime s",
                  style: TextStyle(fontFamily: 'Arima', fontSize: 16, color: Colors.black)),
            ],
          ),
        ],
      ),
      body: quizzes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("Score: $score",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          quizzes[index].question ?? "Question introuvable",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: List.generate(
                          quizzes[index].answers!.length,
                              (i) => AnswerButton(
                            text: quizzes[index].answers![i],
                            color: Colors.blue,
                            onPressed: () => checkAnswer(index, i),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Format des boutons de réponse
class AnswerButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const AnswerButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}