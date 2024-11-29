import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'KitDeSurvie.dart';


class StoryPage extends StatelessWidget {
  const StoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: StoryPageContent(),
      ),
    );
  }
}

class StoryPageContent extends StatelessWidget {
  const StoryPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          NavigationBar(),
          Expanded(
            child: StoryContent(),
          ),
          Footer(),
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color(0xFFE6EFE3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Image.asset(
              'assets/images/profil.png',
              width: 35,
              height: 35,
            ),
            onPressed: () {
              // Actions pour l'icône de profil (par exemple, ouvrir un profil ou paramètres)
            },
          ),
          Text(
            'Histoire de la Terre',
            style: GoogleFonts.arima(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryContent extends StatelessWidget {
  const StoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Introduction à l'histoire
        Text(
          'L\'histoire de Tiko et le tremblement de terre',
          style: GoogleFonts.arima(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),

        // Texte et image côte à côte
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Tiko est un petit oiseau qui vit dans un grand arbre avec ses amis. Un jour, alors qu\'il joue dehors, il ressent une secousse sous ses pattes. "Qu\'est-ce que c\'est ?", se demande-t-il.',
                style: GoogleFonts.arima(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/an2.png',
                height: 150,
                fit: BoxFit.contain,  // Utilisation de BoxFit.contain
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image en premier
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 16 / 9, // Par exemple, pour un ratio 16:9
                child: Image.asset(
                  'assets/images/an2.png',
                  height: 150,
                  fit: BoxFit.contain,  // Utilisation de BoxFit.contain
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Texte après l'image
            Expanded(
              flex: 3,
              child: Text(
                'C\'était un tremblement de terre ! Tiko a eu un peu peur, mais il se souvient de ce qu\'il a appris : "Ne panique pas, trouve un endroit sûr !"',
                style: GoogleFonts.arima(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),


        const SizedBox(height: 20),

        // Texte et image pour l'abri
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Tiko se cache sous une grande pierre, à l\'abri des objets qui peuvent tomber. Heureusement, il se rappelle aussi de vérifier s\'il est en sécurité avec ses amis.',
                style: GoogleFonts.arima(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/an2.png',
                height: 150,
                fit: BoxFit.contain,  // Utilisation de BoxFit.contain
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Conclusion
        Text(
          'Merci d\'avoir lu cette histoire avec Tiko ! Maintenant, tu sais comment réagir en cas de tremblement de terre. Ensemble, nous sommes plus forts et plus sûrs !',
          style: GoogleFonts.arima(
            fontSize: 18,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: () {
            // Action après l'histoire
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC7E4BF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          ),
          child: Text(
            'J\'ai compris !',
            style: GoogleFonts.arima(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
