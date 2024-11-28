import 'package:cap/home_page.dart';
import 'package:cap/pages/reglages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
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
      home: const HomePage(),
      routes: {
        '/settings': (context) => const SettingsPage(),
        '/privacy': (context) => const PrivacyPolicyPage(),
        '/terms': (context) => const TermsPage(),
      },
    );
  }
}




