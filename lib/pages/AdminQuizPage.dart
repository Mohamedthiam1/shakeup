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
  String _difficultyLevel = "1";
  bool _isTextInput = true;

  List<Map<String, dynamic>> questions = [];

  void _addQuestion() {
    setState(() {
      questions.add({
        "questionType": _isTextInput ? "text" : "image",
        "question": _questionController.text,
        "choiceA": _choiceAController.text,
        "choiceB": _choiceBController.text,
        "choiceC": _choiceCController.text,
        "choiceD": _choiceDController.text,
        "correctAnswer": _correctAnswer,
        "difficultyLevel": _difficultyLevel,
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un Quiz',
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Container(
            alignment: Alignment.center,
            width: width,
            child: SizedBox(
              width: width * 0.82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title Section
                  Text(
                    'Ajouter une question',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arima',
                      fontWeight: FontWeight.w400,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Question Input Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Type de question (image/texte) :",
                        style: TextStyle(
                          fontFamily: 'Arima',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.teal[800],
                        ),
                      ),
                      Switch(
                        value: _isTextInput,
                        onChanged: (value) {
                          setState(() {
                            _isTextInput = value;
                            _questionController.clear();
                          });
                        },
                        activeColor: Colors.teal,
                      ),
                      Text(
                        _isTextInput ? "Texte" : "Image",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.teal[800],
                          fontFamily: 'Arima',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

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
                    child: _isTextInput
                        ? TextField(
                      controller: _questionController,
                      decoration: const InputDecoration(
                        labelText: 'Entrez la question',
                        border: InputBorder.none,
                      ),
                    )
                        : ElevatedButton.icon(
                      onPressed: () {
                        // Implement image picker here
                      },
                      icon: const Icon(Icons.image, color: Colors.teal), // Icon avec la couleur désirée
                      label: const Text(
                        "Ajouter une image",
                        style: TextStyle(
                            fontFamily: 'Arima',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.teal), // Texte avec la même couleur
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[50], // Couleur claire pour le bouton
                        elevation: 0, // Supprimer les ombres
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Coins arrondis
                          side: const BorderSide(color: Colors.teal), // Bordure fine
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Taille du bouton
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Difficulty Level Dropdown
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.teal[100], // Lighter color
                      border: Border.all(color: Colors.teal, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: _difficultyLevel,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _difficultyLevel = newValue!;
                        });
                      },
                      items: <String>['1', '2', '3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            "Niveau $value",
                            style: const TextStyle(
                              fontFamily: 'Arima',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
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
                        style: TextStyle(
                            fontFamily: 'Arima',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.teal[800]),
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
                        style: TextStyle(
                          fontFamily: 'Arima',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Display Added Questions
                  Text(
                    'Questions ajoutées :',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arima',
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
                                  question["questionType"] == "text"
                                      ? question["question"]
                                      : "Image ajoutée",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Arima',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
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
                                    fontFamily: 'Arima',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.teal[800],
                                  ),
                                ),
                                Text(
                                  'Niveau de difficulté : ${question["difficultyLevel"]}',
                                  style: TextStyle(
                                    fontFamily: 'Arima',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.teal[600],
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
        ),
      ),
    );
  }

  // Helper widget for choice inputs
  Widget _buildChoiceInput(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
