import 'dart:io';

import 'package:cap/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/showloading.dart';

class AddQuizzScreen extends StatefulWidget {
  const AddQuizzScreen({super.key});

  @override
  State<AddQuizzScreen> createState() => _AddQuizzScreenState();
}

class _AddQuizzScreenState extends State<AddQuizzScreen> {
  late TextEditingController questionController;
  late TextEditingController firstController;
  late TextEditingController secondController;
  late TextEditingController thirdController;
  late TextEditingController fourthController;
  String imageUrl = "";
  int? correctResponse;

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController();
    firstController = TextEditingController();
    secondController = TextEditingController();
    thirdController = TextEditingController();
    fourthController = TextEditingController();
  }

  @override
  void dispose() {
    questionController.dispose();
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouveau Quizz"),
      ),
      bottomNavigationBar: Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: width * 0.06),
              backgroundColor: const Color.fromRGBO(11, 192, 103, 1.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              )
          ),
          onPressed: _submitQuiz,
          child: Text("ENREGISTRER", overflow: TextOverflow.ellipsis, style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 175,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: _getImage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: imageXFile == null
                            ? Container(
                          alignment: Alignment.center,
                          child: Text("Cliquez pour choisir une image"),
                        )
                            : Container(
                          width: width * 0.90,
                          height: 175,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: FileImage(File(imageXFile!.path)), fit: BoxFit.cover)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Question Input
            TextField(
              controller: questionController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: "Question"),
            ),
            const SizedBox(height: 15),

            // Answer Options
            _buildAnswerOption(0, firstController),
            _buildAnswerOption(1, secondController),
            _buildAnswerOption(2, thirdController),
            _buildAnswerOption(3, fourthController),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOption(int index, TextEditingController controller) {
    return Row(
      children: [
        Radio<int>(
          value: index,
          groupValue: correctResponse,
          onChanged: (int? value) {
            setState(() {
              correctResponse = value;
            });
          },
        ),
        Expanded(
          child: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: "Réponse ${index + 1}"),
          ),
        ),
      ],
    );
  }

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });

    if(imageXFile != null) {
      // Fluttertoast.showToast(msg: "Aucune photo choisie!", timeInSecForIosWeb: 2);
    }
    else {
      Fluttertoast.showToast(msg: "Aucune photo choisie!", timeInSecForIosWeb: 2);
    }
  }

  Future<void> _submitQuiz() async {
    if (questionController.text.isEmpty ||
        firstController.text.isEmpty ||
        secondController.text.isEmpty ||
        thirdController.text.isEmpty ||
        fourthController.text.isEmpty ||
        correctResponse == null) {
      Fluttertoast.showToast(msg: "Veuillez remplir tous les champs et choisir une réponse correcte.", timeInSecForIosWeb: 5);
      return;
    }
    showloading(context);

    // Create a quiz object (this can be modified to fit your backend structure)
    // final quiz = {
    //   "question": questionController.text,
    //   "answers": [
    //     firstController.text,
    //     secondController.text,
    //     thirdController.text,
    //     fourthController.text
    //   ],
    //   "correctIndex": correctResponse,
    // };

    // print("Quiz Submitted: $quiz"); // Replace with actual save logic
    String quizzID = DateTime.now().millisecondsSinceEpoch.toString();

    if(imageXFile != null) {
      storage.Reference reference = storage.FirebaseStorage.instance.ref().child("quizzes").child(quizzID);
      storage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
      storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        imageUrl = url;
        //Save informations to Firestore Database

      });
    }

    await FirebaseFirestore.instance.collection("quizzes").doc(quizzID).set({
      "quizzID": quizzID,
      "question": questionController.text,
      "answers": [
        firstController.text,
        secondController.text,
        thirdController.text,
        fourthController.text,
      ],
      "correctOne": correctResponse,
      "pictureUrl": imageUrl,
      "whoSubmitted": sharedPreferences!.getString("uid"),
      "created": DateTime.now()
    }).whenComplete((){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Question ajoutée avec succès!", timeInSecForIosWeb: 5);
    });

    // Clear fields after submission
    questionController.clear();
    firstController.clear();
    secondController.clear();
    thirdController.clear();
    fourthController.clear();
    setState(() {
      correctResponse = null;
      imageXFile = null;
    });
  }
}

/*
SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
        .then((_) {

    });
 */