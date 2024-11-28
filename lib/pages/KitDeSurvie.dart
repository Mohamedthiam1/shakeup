import 'package:flutter/material.dart';

class KitDeSurviePage extends StatelessWidget {
  const KitDeSurviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de flèche
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text("Kit de survie",
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
      
      body: Column(
        children: [
          // Contenu principal (Kit de Survie sous forme de liste)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ListTile(
                  leading: const Icon(Icons.local_drink, color: Colors.blue, size: 40),
                  title: const Text(
                    'Eau potable',
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: const Text(
                    'Glou glou ! Reste hydraté comme un super-héros avec au moins 3 litres d’eau !',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.healing, color: Colors.red, size: 40),
                  title: const Text(
                    'Trousse de secours',
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: const Text(
                    'Des pansements magiques et des potions (désinfectant) pour soigner les bobos !',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.flashlight_on, color: Colors.yellow, size: 40),
                  title: const Text(
                    'Lampe de poche',
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: const Text(
                    'Pour explorer les ombres comme un aventurier... avec des piles de rechange bien sûr !',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.fastfood, color: Colors.orange, size: 40),
                  title: const Text(
                    'Nourriture magique',
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: const Text(
                    'Des barres énergétiques et des conserves pour devenir fort comme un lion !',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.bed, color: Colors.purple, size: 40),
                  title: const Text(
                    'Couverture câline',
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: const Text(
                    'Un manteau de chaleur pour rester bien au chaud comme un ours en hiver !',
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
      // Footer en bas de la page
      // bottomNavigationBar: const Footer(),
    );
  }
}


