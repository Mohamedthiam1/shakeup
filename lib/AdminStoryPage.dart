import 'package:flutter/material.dart';

class AdminStoryPage extends StatefulWidget {
  const AdminStoryPage({super.key});

  @override
  _AdminStoryPageState createState() => _AdminStoryPageState();
}

class _AdminStoryPageState extends State<AdminStoryPage> {
  final _titleController = TextEditingController();
  final _paragraph1Controller = TextEditingController();
  final _paragraph2Controller = TextEditingController();
  final _paragraph3Controller = TextEditingController();
  List<String> images = ["", "", ""]; // Images for each paragraph

  void _addImage(int index) {
    // TODO: Implement image picker logic here
    setState(() {
      images[index] = "Image $index ajoutée"; // Placeholder for the image path
    });
  }

  void _submitStory() {
    final story = {
      "title": _titleController.text,
      "paragraphs": [
        {"text": _paragraph1Controller.text, "image": images[0]},
        {"text": _paragraph2Controller.text, "image": images[1]},
        {"text": _paragraph3Controller.text, "image": images[2]},
      ],
    };

    print("Histoire créée : $story"); // Temporary debug action
    // TODO: Save story to the backend or local storage

    // Clear inputs after submission
    _titleController.clear();
    _paragraph1Controller.clear();
    _paragraph2Controller.clear();
    _paragraph3Controller.clear();
    setState(() {
      images = ["", "", ""];
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text('Créer une Histoire',
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100], // Couleur de fond verte pour l'AppBar
        centerTitle: true,
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
                    'Ajouter une Histoire',
                    style: TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title Input
                  _buildInputField(_titleController, 'Titre de l\'histoire'),
                  const SizedBox(height: 16),

                  // First Paragraph
                  _buildParagraphSection(
                    controller: _paragraph1Controller,
                    paragraphNumber: 1,
                  ),
                  const SizedBox(height: 16),

                  // Second Paragraph
                  _buildParagraphSection(
                    controller: _paragraph2Controller,
                    paragraphNumber: 2,
                  ),
                  const SizedBox(height: 16),

                  // Third Paragraph
                  _buildParagraphSection(
                    controller: _paragraph3Controller,
                    paragraphNumber: 3,
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
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
                      onPressed: _submitStory,
                      child: const Text(
                        'Créer l\'Histoire',
                        style: TextStyle(
                          fontFamily: 'Arima',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
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

  // Widget to build input fields
  Widget _buildInputField(TextEditingController controller, String label) {
    return Container(
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
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Widget for each paragraph section
  Widget _buildParagraphSection({
    required TextEditingController controller,
    required int paragraphNumber,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Paragraph Input
        _buildInputField(
            controller, 'Paragraphe $paragraphNumber (contenu texte)'),
        const SizedBox(height: 8),

        // Add Image Button
        ElevatedButton.icon(
          onPressed: () => _addImage(paragraphNumber - 1),
          icon: const Icon(Icons.image, color: Colors.teal),
          label: Text(
            images[paragraphNumber - 1].isEmpty
                ? "Ajouter une image"
                : "Modifier l'image",
            style: const TextStyle(color: Colors.teal),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[50],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.teal),
            ),
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
