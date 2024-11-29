import 'package:flutter/material.dart';

class Story3 extends StatelessWidget {
  const Story3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: StoryPageContent3(),
      ),
    );
  }
}

class StoryPageContent3 extends StatelessWidget {
  const StoryPageContent3({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Introduction à l'histoire
        Text(
          'Le plan malin de Zina la zèbre',
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
                'Zina la zèbre vivait dans une savane magnifique où le sol était parfois secoué par de grands tremblements. Un jour, alors qu’elle jouait près des arbres, elle sentit une forte secousse. Les branches se balançaient dangereusement, et des fruits tombaient à terre.',
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
                'assets/images/zebre1.png',
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
                  'assets/images/zebre2.png',
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
                'Zina se rappela du plan que sa maman lui avait enseigné : "Si le sol tremble, reste loin des arbres et trouve un endroit dégagé." Elle galopa rapidement jusqu’à une grande plaine sans obstacle et attendit que les secousses s’arrêtent. Elle vit d’autres animaux courir dans tous les sens, mais elle leur cria de venir la rejoindre dans la plaine.',
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
                'Quand tout redevint calme, les animaux la remercièrent pour son sang-froid et son plan intelligent. Depuis ce jour, Zina enseigna à tous les habitants de la savane les bons gestes pour rester en sécurité, même lorsque la terre devenait capricieuse.',
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
                'assets/images/zebre3.png',
                height: 150,
                fit: BoxFit.contain,  // Utilisation de BoxFit.contain
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Conclusion
        Text(
          'Merci d\'avoir lu cette histoire avec Zina ! Maintenant, tu sais comment réagir en cas de tremblement de terre. Ensemble, nous sommes plus forts et plus sûrs !',
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
