import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cap/pages/reglages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'global/audio_manager.dart';
import 'global/global.dart';
import 'legals/privacy_policy.dart';
import 'legals/terms_of_use.dart';
import 'pages/home_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Background message: ${message.messageId}");
}

//Notre fonction main est le point d'entrée de notre application, tout commence ici!
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  //Ici Firebase est initialisé avec les identifiants de notre firebase_options
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  //Si la variable points n'existait pas dans sharedPreferences, on l'initialise
  if(sharedPreferences!.getInt("points") == null) {
    sharedPreferences!.setInt("points", 0);
  }

  //Pareil pour l'âge, il est initialisé à 0
  if(sharedPreferences!.getInt("age") == null) {
    sharedPreferences!.setInt("age", 0);
  }

  //Ici on démare les services de Firebase Messaging pour l'envoi de notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //Nous demandons les permissions nécessaires l'utilisation de notre application
  FirebaseMessaging.instance.requestPermission();
  await [Permission.microphone, Permission.camera].request();
  Permission.locationWhenInUse.request();

    try {
      // Ici, nous allons d'abord récupérer l'adresse IP de l'utilisateur avec un API gratuite
      final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        // We parse the IP address from the response
        final ipData = Map<String, dynamic>.from(jsonDecode(response.body));
        ipAddress = ipData['ip'];
        print("IP address: $ipAddress");

        //Puis ici nous récupérons la localisation de l'appareil en fonction de l'adresse IP précédemment eu
        final locationResponse = await http.get(Uri.parse('http://ip-api.com/json/$ipAddress'));
        if (locationResponse.statusCode == 200) {
          String country = Map<String, dynamic>.from(jsonDecode(locationResponse.body))["country"];
          print(Map<String, dynamic>.from(jsonDecode(locationResponse.body)));
          //En fonction du pays associé à l'adresse, nous modifions la variable myCountry qui va nous permettre d'afficher les numéros d'urgence par la suite
          if(country == "France") {
            myCountry = MyCountry.france;
            numbersToDisplay = frenchNumbers;
          } else if(country == "United States") {
            myCountry = MyCountry.unitedStates;
            numbersToDisplay = unitedStatesNumbers;
          } else if(country == "Japan") {
            myCountry = MyCountry.japan;
            numbersToDisplay = japaneseNumbers;
          } else if(country == "Turkey") {
            myCountry = MyCountry.turkish;
            numbersToDisplay = turkishNumbers;
          } else if(country == "China") {
            myCountry = MyCountry.china;
            numbersToDisplay = chineseNumbers;
          }

          print("My Country is : $myCountry");
        }

        // print("IP Address saved: $ipAddress");
      } else {
        // print("Failed to fetch IP address. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // print("Error retrieving and saving IP address: $e");
    }


    //Nous démarrons la musique en arrière plan
  AudioManager.play();

    //Nous fixons l'orientation du téléphone en mode Paysage
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




