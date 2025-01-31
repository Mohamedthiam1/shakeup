import 'package:flutter/material.dart';

class Story6 extends StatelessWidget {
  const Story6({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: StoryPageContent6(),
      ),
    );
  }
}

class StoryPageContent6 extends StatelessWidget {
  const StoryPageContent6({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Introduction à l'histoire
        const Text(
          'La cachette de Mila la souris',
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
                'Mila la souris adorait sa maison sous la cuisine d’une vieille maison. Mais un jour, en plein après-midi, les murs commencèrent à vibrer et des objets tombèrent des étagères. Mila se souvint des conseils de sa maman : "Va sous la table, protège-toi !".',
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
                'assets/images/souris1.png',
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
                  'assets/images/souris2.png',
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
                'Elle courut sous la grande table de la cuisine et se roula en boule, les pattes sur la tête. Le bruit et les secousses étaient effrayants, mais Mila resta calme. Quand tout s’arrêta, elle sortit prudemment pour vérifier que tout le monde allait bien.',
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
                'Sa famille la félicita pour sa réaction rapide et responsable. Mila devint un exemple pour tous les petits animaux du quartier, leur montrant comment réagir face à un tremblement de terre.',
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
                'assets/images/souris3.png',
                height: 150,
                fit: BoxFit.contain,  // Utilisation de BoxFit.contain
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Conclusion
        const Text(
          'Merci d\'avoir lu cette histoire avec Mila ! Maintenant, tu sais comment réagir en cas de tremblement de terre. Ensemble, nous sommes plus forts et plus sûrs !',
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
