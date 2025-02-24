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
  //On déclare nos variables ici
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
    //On initialise les controllers pour des raisons de performance
    questionController = TextEditingController();
    firstController = TextEditingController();
    secondController = TextEditingController();
    thirdController = TextEditingController();
    fourthController = TextEditingController();
  }

  @override
  void dispose() {
    //On libère les ressources pour des raisons de performance
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
        //Nous enregistrons les données du nouveau quizz
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
                        child: imageXFile == null //Nous verifions si l'image a été déjà choisie ou pas encore
                            ? Container(
                          alignment: Alignment.center,
                          child: Text("Cliquez pour choisir une image"), //Si non on lui demande de la choisir
                        )
                            : Container(
                          width: width * 0.90,
                          height: 175,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: FileImage(File(imageXFile!.path)), fit: BoxFit.cover) // Si c'est déjà fait on l'affiche dans un Container pour controler les dimensions
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Question Input - Nous recupérons la question
            TextField(
              controller: questionController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: "Question"),
            ),
            const SizedBox(height: 15),

            // Answer Options - Nous renseignons les réponses possibles puis nous choisissons la bonne réponse au quizz
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

  //Notre widget pour afficher nos réponses en liste
  Widget _buildAnswerOption(int index, TextEditingController controller) {
    return Row(
      children: [
        //Ce widget Radio nous permettra de ne choisir qu'une seule bonne réponse
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

  //Cette function nous permettra de récupérer l'image depuis la gallerie grâce au package image_picker
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

  //Cette fonction va stocker le nouveau quizz dans la base de donnees pour pouvoir l'utiliser et l'afficher plus tard
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

    String quizzID = DateTime.now().millisecondsSinceEpoch.toString();

    //Ici on enregistre l'image(si elle existe) du quizz sur Firebase Storage
    if(imageXFile != null) {
      storage.Reference reference = storage.FirebaseStorage.instance.ref().child("quizzes").child(quizzID);
      storage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
      storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        //On recupère l'url pour l'utiliser plus tard
        imageUrl = url;
        //Save informations to Firestore Database

      });
    }

    //Et c'est là que nous enregistrions les données sur Firestore
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

    // Après tout on réinitialise et vide les controllers et variables
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