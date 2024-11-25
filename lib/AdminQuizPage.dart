import 'package:flutter/material.dart';

class AdminQuizPage extends StatefulWidget {
  const AdminQuizPage({super.key});

  @override
  _AdminQuizPageState createState() => _AdminQuizPageState();
}

class _AdminQuizPageState extends State<AdminQuizPage> {
  final _questionController = TextEditingController();
  final _choiceAController = TextEditingController();
  final _choiceBController = TextEditingController();
  final _choiceCController = TextEditingController();
  final _choiceDController = TextEditingController();
  String _correctAnswer = "A";

  List<Map<String, String>> questions = [];

  void _addQuestion() {
    setState(() {
      questions.add({
        "question": _questionController.text,
        "choiceA": _choiceAController.text,
        "choiceB": _choiceBController.text,
        "choiceC": _choiceCController.text,
        "choiceD": _choiceDController.text,
        "correctAnswer": _correctAnswer,
      });
    });

    // Clear inputs after adding the question
    _questionController.clear();
    _choiceAController.clear();
    _choiceBController.clear();
    _choiceCController.clear();
    _choiceDController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un Quiz'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'Ajouter une question',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 20),

              // Question Input Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    labelText: 'Entrez la question',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Choices Input Boxes
              _buildChoiceInput(_choiceAController, 'Choix A'),
              _buildChoiceInput(_choiceBController, 'Choix B'),
              _buildChoiceInput(_choiceCController, 'Choix C'),
              _buildChoiceInput(_choiceDController, 'Choix D'),
              const SizedBox(height: 16),

              // Correct Answer Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Réponse correcte :',
                    style: TextStyle(fontSize: 16, color: Colors.teal[800]),
                  ),
                  DropdownButton<String>(
                    value: _correctAnswer,
                    onChanged: (String? newValue) {
                      setState(() {
                        _correctAnswer = newValue!;
                      });
                    },
                    items: <String>['A', 'B', 'C', 'D']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Add Question Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: _addQuestion,
                  child: const Text(
                    'Ajouter la Question',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Display Added Questions
              Text(
                'Questions ajoutées :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question["question"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('A: ${question["choiceA"]}'),
                            Text('B: ${question["choiceB"]}'),
                            Text('C: ${question["choiceC"]}'),
                            Text('D: ${question["choiceD"]}'),
                            const SizedBox(height: 8),
                            Text(
                              'Réponse correcte : ${question["correctAnswer"]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for choice inputs
  Widget _buildChoiceInput(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.teal, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
