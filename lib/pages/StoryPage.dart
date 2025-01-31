import 'package:flutter/material.dart';

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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Introduction à l'histoire
        const Text(
          'L\'histoire de Tiko et le tremblement de terre',
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'Arima',
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),

        // Texte et image côte à côte
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 3,
              child: Text(
                'Tiko est un petit oiseau qui vit dans un grand arbre avec ses amis. Un jour, alors qu\'il joue dehors, il ressent une secousse sous ses pattes. "Qu\'est-ce que c\'est ?", se demande-t-il.',
                style: TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
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
            const Expanded(
              flex: 3,
              child: Text(
                'C\'était un tremblement de terre ! Tiko a eu un peu peur, mais il se souvient de ce qu\'il a appris : "Ne panique pas, trouve un endroit sûr !"',
                style: TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
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
            const Expanded(
              flex: 3,
              child: Text(
                'Tiko se cache sous une grande pierre, à l\'abri des objets qui peuvent tomber. Heureusement, il se rappelle aussi de vérifier s\'il est en sécurité avec ses amis.',
                style: TextStyle(
                  fontFamily: 'Arima',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
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
        const Text(
          'Merci d\'avoir lu cette histoire avec Tiko ! Maintenant, tu sais comment réagir en cas de tremblement de terre. Ensemble, nous sommes plus forts et plus sûrs !',
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Retour à la page précédente
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC7E4BF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          ),
          child: const Text(
            'J\'ai compris !',
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
