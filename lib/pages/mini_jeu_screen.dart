import 'package:cap/pages/KitDeSurvie.dart';
import 'package:cap/pages/evite%20les%20danger.dart';
import 'package:flutter/material.dart';

import 'TrouverAbriPage.dart';
import 'home_page.dart';


class MiniJeuScreen extends StatefulWidget {
  const MiniJeuScreen({super.key});

  @override
  State<MiniJeuScreen> createState() => _MiniJeuScreenState();
}

class _MiniJeuScreenState extends State<MiniJeuScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text("Mini jeux",
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100], // Couleur de fond verte pour l'AppBar
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TrouverAbriPage()));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.22, // 30% de la largeur de l'écran
                      child: Image.asset('assets/images/img5.jpg'),
                    ),
                  ),
                  const Text('Trouver l’abri',
                    style: TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const KitDeSurviePage()));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.22, // 30% de la largeur de l'écran
                      child: Image.asset('assets/images/img4.jpg'),
                    ),
                  ),
                  const Text('Kit de survie',
                    style: TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const DangerPage()));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.22, // 30% de la largeur de l'écran
                      child: Image.asset('assets/images/img3.jpg'),
                    ),
                  ),
                  const Text('Éviter les dangers',
                    style: TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(), // Footer en bas
    );
  }
}