import 'package:flutter/material.dart';

class Story4 extends StatelessWidget {
  const Story4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: StoryPageContent4(),
      ),
    );
  }
}

class StoryPageContent4 extends StatelessWidget {
  const StoryPageContent4({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Introduction à l'histoire
        Text(
          'La grande leçon de Sam le hérisson',
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
                'Sam le hérisson vivait paisiblement dans une forêt proche des montagnes. Un jour, le sol se mit à trembler sous ses pattes. Effrayé, il courut dans toutes les directions sans savoir où aller. Il se coinça sous un arbre qui menaçait de tomber.',
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
                'assets/images/hérisson1.png',
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
                  'assets/images/hérisson2.png',
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
                'Heureusement, sa voisine Lina la tortue lui avait montré un abri solide près de la rivière. Sam y alla en sécurité et y retrouva ses amis. Ils restèrent calmes et attendirent que les secousses s’arrêtent. Ils avaient suivi les conseils de Lina : "Un lieu sûr est la clé pour se protéger !".',
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
                'Après cela, Sam apprit qu’il fallait se préparer et ne jamais paniquer. Avec ses amis, il construisit des abris pour tout le village des animaux. Depuis ce jour, ils se sentaient en sécurité, même quand le sol tremblait.',
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
                'assets/images/hérisson3.png',
                height: 150,
                fit: BoxFit.contain,  // Utilisation de BoxFit.contain
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Conclusion
        Text(
          'Merci d\'avoir lu cette histoire avec Sam ! Maintenant, tu sais comment réagir en cas de tremblement de terre. Ensemble, nous sommes plus forts et plus sûrs !',
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
