import 'package:cap/pages/reglages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'global/global.dart';
import 'pages/home_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Background message: ${message.messageId}");
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  if(sharedPreferences!.getInt("points") == null) {
    sharedPreferences!.setInt("points", 0);
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.requestPermission();
  await [Permission.microphone, Permission.camera].request();
  Permission.locationWhenInUse.request();

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
}

// StatelessWidget   taper st    //pour consulter du contenu ex page d accueil
// StatefulWidget       //quand y a dynamisation de la page ex mise à jour d'un contenu comme les case pour les quiz
// voir vidéo 2 17:50min pour la police d'écriture

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          '/settings': (context) => const SettingsPage(),
          '/privacy': (context) => const PrivacyPolicyPage(),
          '/terms': (context) => const TermsPage(),
        },
      ),
    );
  }
}




