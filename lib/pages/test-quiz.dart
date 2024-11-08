import 'package:flutter/material.dart';
import 'dart:async';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int remainingTime = 30; // Initial countdown time in seconds
  Timer? _timer; // Timer variable

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when page is disposed to prevent memory leaks
    super.dispose();
  }

  // Function to start the countdown timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        // You can trigger an action here when the time reaches zero, like ending the quiz
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test-Quiz"),
        backgroundColor: Colors.green[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row for points and timer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons8-police-badge-40.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 4),
                    const Text("NB points gagnés"),   //voir avec firebase pour changer la fct du nb de pnts
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons8-time-40.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 4),
                    Text("$remainingTime sec"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Question container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Question/animation/image",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),

            // Answer buttons grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: const [
                  AnswerButton(text: "Réponse A", color: Colors.red),
                  AnswerButton(text: "Réponse B", color: Colors.green),
                  AnswerButton(text: "Réponse C", color: Colors.yellow),
                  AnswerButton(text: "Réponse D", color: Colors.blue),
                ],
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
  final Color color;

  const AnswerButton({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Fixed width for a smaller rectangle
      height: 60, // Fixed height for a smaller rectangle
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.zero,
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // voir pour la suite
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}