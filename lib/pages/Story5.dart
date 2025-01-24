import 'package:flutter/material.dart';

class Story5 extends StatelessWidget {
  const Story5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: StoryPageContent5(),
      ),
    );
  }
}

class StoryPageContent5 extends StatelessWidget {
  const StoryPageContent5({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Introduction à l'histoire
        Text(
          'L\'abri magique de Karim le kangourou ',
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
            Expanded(
              flex: 3,
              child: Text(
                'Karim le kangourou aimait jouer près des rochers, mais son grand-père lui répétait toujours : "Les rochers ne sont pas sûrs en cas de tremblement de terre ". Karim n’y prêtait pas attention, jusqu’au jour où la terre trembla fortement.',
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
                'assets/images/Kangourou1.jpg',
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
                  'assets/images/Kangourou2.jpg',
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
                'Se souvenant des paroles de son grand-père, Karim sauta rapidement dans une zone dégagée, loin des arbres et des rochers. Là-bas, il retrouva ses amis et attendit que tout s’arrête. Le grand-père les rejoignit et expliqua pourquoi un endroit dégagé était si important.',
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
            Expanded(
              flex: 3,
              child: Text(
                'Depuis ce jour, Karim et ses amis jouaient toujours en sécurité, et ils apprenaient aux plus jeunes où se mettre à l\'abri quand le sol se met à trembler.',
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
                'assets/images/Kangourou3.png',
                height: 150,
                fit: BoxFit.contain,  // Utilisation de BoxFit.contain
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Conclusion
        Text(
          'Merci d\'avoir lu cette histoire avec Karim ! Maintenant, tu sais comment réagir en cas de tremblement de terre. Ensemble, nous sommes plus forts et plus sûrs !',
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
          child: Text(
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
