import 'package:flutter/material.dart';



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
        title: Center(child: Text('Mini Jeux')),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: screenWidth * 0.3, // 30% de la largeur de l'écran
                    child: Image.asset('assets/images/img5.jpg'),
                  ),
                  Text('Trouver l’abri'),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  SizedBox(
                    width: screenWidth * 0.3, // 30% de la largeur de l'écran
                    child: Image.asset('assets/images/img4.jpg'),
                  ),
                  Text('Kit de survie'),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  SizedBox(
                    width: screenWidth * 0.3, // 30% de la largeur de l'écran
                    child: Image.asset('assets/images/img3.jpg'),
                  ),
                  Text('Éviter les dangers'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}