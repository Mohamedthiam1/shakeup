import 'package:flutter/material.dart';
import 'package:shakeup/pages/reglages.dart';
import 'package:shakeup/pages/salon.dart';

void main() {
  runApp(MyApp());
}

//StatelessWidget   taper st    //pour consulter du contenu ex page d accueil
//StatefulWidget       //quand y a dynamisation de la page ex mise à jour d'un contenu comme les case pour les quiz
//voir vidéo 2 17:50min pour la police d'écriture

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SalonPage(),
      routes: {
        '/privacy': (context) => const PrivacyPolicyPage(),
        '/terms': (context) => const TermsPage(),
      },
    );
  }
}




