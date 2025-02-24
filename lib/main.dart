import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cap/pages/reglages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  if(sharedPreferences!.getInt("points") == null) {
    sharedPreferences!.setInt("points", 0);
  }

  if(sharedPreferences!.getInt("age") == null) {
    sharedPreferences!.setInt("age", 0);
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.requestPermission();
  await [Permission.microphone, Permission.camera].request();
  Permission.locationWhenInUse.request();

    try {
      // Fetch the IP address using a public API
      final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        // Parse the IP address from the response
        final ipData = Map<String, dynamic>.from(jsonDecode(response.body));
        ipAddress = ipData['ip'];
        print("IP address: $ipAddress");

        final locationResponse = await http.get(Uri.parse('http://ip-api.com/json/$ipAddress'));
        if (locationResponse.statusCode == 200) {
          String country = Map<String, dynamic>.from(jsonDecode(locationResponse.body))["country"];
          print(Map<String, dynamic>.from(jsonDecode(locationResponse.body)));
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


  AudioManager.play();

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




