import 'package:flutter/material.dart';

import 'package:cap/pages/Story2.dart';
import 'package:cap/pages/Story3.dart';
import 'package:cap/pages/Story4.dart';
import 'package:cap/pages/Story5.dart';
import 'package:cap/pages/Story6.dart';

import 'StoryPage.dart';
import 'home_page.dart';


class ModeHistoirePage extends StatelessWidget {
  const ModeHistoirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text(
          "Histoires",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alignement vertical en haut
          crossAxisAlignment: CrossAxisAlignment.center, // Alignement horizontal au centre
          children: [
            const SizedBox(height: 20), // Espace entre le titre et les images

            // Première rangée d'images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacement uniforme
              children: [
                _buildImageCard(context, 'assets/images/histoire1.jpg', const StoryPage()),
                _buildImageCard(context, 'assets/images/etoile1.png', const Story2()),
                _buildImageCard(context, 'assets/images/zebre1.png', const Story3()),
              ],
            ),

            const SizedBox(height: 20), // Espace entre les rangées

            // Deuxième rangée d'images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacement uniforme
              children: [
                _buildImageCard(context, 'assets/images/hérisson1.webp', const Story4()),
                _buildImageCard(context, 'assets/images/Kangourou1.jpg', const Story5()),
                _buildImageCard(context, 'assets/images/souris1.png', const Story6()),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(), // Footer en bas
    );
  }

  /// Widget helper pour créer une carte d'image cliquable
  Widget _buildImageCard(BuildContext context, String imagePath, Widget destinationPage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage), // Navigation vers la page de l'histoire
        );
      },
      child: Image.asset(
        imagePath,
        width: 90, // Largeur de l'image
        height: 90, // Hauteur de l'image
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            size: 50,
            color: Colors.grey,
          ); // Icône de remplacement si l'image ne charge pas
        },
      ),
    );
  }
}
