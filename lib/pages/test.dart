import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddImageTrouverAbriScreen extends StatefulWidget {
  const AddImageTrouverAbriScreen({super.key});

  @override
  State<AddImageTrouverAbriScreen> createState() => _AddImageTrouverAbriScreenState();
}

class _AddImageTrouverAbriScreenState extends State<AddImageTrouverAbriScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _answerController = TextEditingController();

  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadTrouverAbri() async {
    if (_imageFile == null || _answerController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Veuillez sélectionner une image et entrer la réponse correcte.");
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload image to Firebase Storage
      String trouverAbriID = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("trouver_abri")
          .child("$trouverAbriID.jpg");

      firebase_storage.UploadTask uploadTask = ref.putFile(File(_imageFile!.path));
      final snapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Save TrouverAbri details in Firestore
      await FirebaseFirestore.instance.collection("trouver_abri").doc(trouverAbriID).set({
        "imageUrl": imageUrl,
        "correctAnswer": _answerController.text.trim(),
      });

      Fluttertoast.showToast(msg: "TrouverAbri ajouté avec succès !");
      setState(() {
        _imageFile = null;
        _answerController.clear();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Erreur : ${e.toString()}");
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un TrouverAbri"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _imageFile == null
                    ? const Center(child: Text("Cliquez pour choisir une image"))
                    : Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: "Réponse correcte"),
            ),
            const SizedBox(height: 20),
            _isUploading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _uploadTrouverAbri,
              child: const Text("Ajouter TrouverAbri"),
            ),
          ],
        ),
      ),
    );
  }
}
