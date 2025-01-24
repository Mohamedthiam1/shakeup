import 'package:flutter/material.dart';

//page d'informations "Pendant un Séisme"
class PendantScreen extends StatefulWidget {
  const PendantScreen({super.key});

  @override
  State<PendantScreen> createState() => _PendantScreenState(); // Récupération de la largeur de l'écran pour une mise en page réactive
}

class _PendantScreenState extends State<PendantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text("Pendant un Séisme",
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
      body: Padding(
        padding: EdgeInsets.all(16.0), // Marges autour du contenu pour un espacement uniforme
        child: SingleChildScrollView(
          // Permet le défilement si le contenu dépasse la hauteur de l'écran
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Vérifiez si tout va bien
              _buildSection(
                '1. Reste calme 😊',
                'Ne panique pas, respire profondément et essaie de garder ton sang-froid.',
                Icons.self_improvement,
              ),

              // Section 2: Reste loin des endroits dangereux
              _buildSection(
                '2. Baisse-toi 🚧',
                'Mets-toi rapidement à genoux pour ne pas perdre l’équilibre si le sol bouge.',
                Icons.accessibility_new,
              ),

              // Section 3: Appelle un adulte si besoin
              _buildSection(
                '3. Cache-toi sous une table solide 🛡️',
                'Trouve un abri sous un meuble stable, comme une table ou un bureau. Cela te protégera des objets qui pourraient tomber.',
                Icons.table_bar,
              ),

              // Section 4: Écoute les consignes
              _buildSection(
                '4. Accroche-toi ✋',
                'Tiens fermement la table ou le meuble sous lequel tu te caches pour éviter qu’il ne bouge.',
                Icons.handshake,
              ),

              // Section 6: Ne retourne pas tout de suite à la maison
              _buildSection(
                '5. Éloigne-toi des fenêtres et des objets qui peuvent tomber 🪟',
                ' Reste loin des vitres, des étagères ou des appareils qui pourraient tomber ou se casser.',
                Icons.window,
              ),

              // Section 7: Participe à aider
              _buildSection(
                '6. Si tu es à l\'extérieur 🏞️',
                'Éloigne-toi des bâtiments, des arbres, des lampadaires, et des lignes électriques.\n Trouve un espace ouvert et reste au sol jusqu\'à ce que les secousses s\'arrêtent.',
                Icons.park,
              ),

              // Section 7: Participe à aider
              _buildSection(
                '7. Si tu es en voiture 🚗',
                'Arrête-toi en sécurité, loin des ponts, des tunnels et des bâtiments. \n Reste dans la voiture jusqu\'à ce que les secousses cessent.',
                Icons.directions_car,
              ),

              // Section 7: Participe à aider
              _buildSection(
                '8. Évite les escaliers et les ascenseurs 🚷',
                'Les escaliers pourraient s’effondrer et les ascenseurs pourraient se bloquer.',
                Icons.stairs,
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Retour à la page précédente
                  },
                  child: const Text('Retour à l\'Accueil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 32, color: Colors.blueAccent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Arima',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}