import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//page d'informations "Pendant un Séisme"
class PendantScreen extends StatefulWidget {
  const PendantScreen({super.key});

  @override
  State<PendantScreen> createState() => _PendantScreenState(); // Récupération de la largeur de l'écran pour une mise en page réactive
}

class _PendantScreenState extends State<PendantScreen> {
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpening(); // Vérifie si l'utilisateur ouvre la page pour la première fois
    _loadLanguage();
  }

  // Vérifie si c'est la première fois que l'utilisateur ouvre cette page
  Future<void> _checkFirstTimeOpening() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasOpenedBefore = prefs.getBool('opened_educational_file') ?? false;

    if (!hasOpenedBefore) {
      await prefs.setBool('opened_educational_file', true); // Enregistre l'ouverture
      _showBadgePopup(); // Affiche le pop-up immédiatement
    }
  }

  // Affiche une boîte de dialogue pour signaler que l'utilisateur a débloqué un badge
  void _showBadgePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.search, color: Colors.blue, size: 40),
              const SizedBox(width: 10),
              Text(selectedLanguage == 'Français' ? 'Badge Débloqué !' : 'Badge Unlocked !'),
            ],
          ),
          content: Text(
            selectedLanguage == 'Français'
                ? 'Félicitations ! Tu as obtenu le badge "Chercheur débutant".'
                : 'Congratulations ! You have earned the "Beginner Explorer" badge.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le pop-up
              },
              child: const Text("OK", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language');
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

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
        title: Text(
          selectedLanguage == 'Français' ? 'Pendant un Séisme' : 'During an Earthquake',
          style: const TextStyle(
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
        padding: const EdgeInsets.all(16.0), // Marges autour du contenu pour un espacement uniforme
        child: SingleChildScrollView(
          // Permet le défilement si le contenu dépasse la hauteur de l'écran
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Vérifiez si tout va bien
              _buildSection(
                selectedLanguage == 'Français' ? '1. Reste calme 😊' : '1. Stay calm 😊',
                selectedLanguage == 'Français'
                    ? 'Ne panique pas, respire profondément et essaie de garder ton sang-froid.'
                    : 'Do not panic, take deep breaths and try to stay calm.',
                Icons.self_improvement,
              ),

              // Section 2: Reste loin des endroits dangereux
              _buildSection(
                selectedLanguage == 'Français' ? '2. Baisse-toi 🚧' : '2. Drop down 🚧',
                selectedLanguage == 'Français'
                    ? 'Mets-toi rapidement à genoux pour ne pas perdre l’équilibre si le sol bouge.'
                    : 'Quickly get on your knees to avoid losing balance if the ground shakes.',
                Icons.accessibility_new,
              ),

              // Section 3: Appelle un adulte si besoin
              _buildSection(
                selectedLanguage == 'Français' ? '3. Cache-toi sous une table solide 🛡️' : '3. Hide under a solid table 🛡️',
                selectedLanguage == 'Français'
                    ? 'Trouve un abri sous un meuble stable, comme une table ou un bureau.'
                    : 'Find shelter under solid furniture like a table or desk.',
                Icons.table_bar,
              ),

              // Section 4: Écoute les consignes
              _buildSection(
                selectedLanguage == 'Français' ? '4. Accroche-toi ✋' : '4. Hold on ✋',
                selectedLanguage == 'Français'
                    ? 'Tiens fermement la table ou le meuble sous lequel tu te caches pour éviter qu’il ne bouge.'
                    : 'Hold onto the furniture you are under to prevent it from moving.',
                Icons.handshake,
              ),

              // Section 6: Ne retourne pas tout de suite à la maison
              _buildSection(
                selectedLanguage == 'Français' ? '5. Éloigne-toi des fenêtres et objets dangereux 🪟' : '5. Stay away from windows & objects 🪟',
                selectedLanguage == 'Français'
                    ? 'Reste loin des vitres, des étagères ou des appareils qui pourraient tomber.'
                    : 'Stay away from windows, shelves, or appliances that could fall.',
                Icons.window,
              ),

              // Section 7: Participe à aider
              _buildSection(
                selectedLanguage == 'Français' ? '6. Si tu es à l\'extérieur 🏞️' : '6. If you’re outside 🏞️',
                selectedLanguage == 'Français'
                    ? 'Éloigne-toi des bâtiments, des arbres, des lampadaires, et des lignes électriques.\n Trouve un espace ouvert et reste au sol jusqu\'à ce que les secousses s\'arrêtent.'
                    : 'Move away from buildings, trees, street lights, and power lines.\nFind an open space and stay on the ground until the shaking stops.',
                Icons.park,
              ),

              // Section 7: Participe à aider
              _buildSection(
                selectedLanguage == 'Français' ? '7. Si tu es en voiture 🚗' : '7. If You’re in a car 🚗',
                selectedLanguage == 'Français'
                    ? 'Arrête-toi en sécurité, loin des ponts, tunnels et bâtiments.\n Reste dans la voiture jusqu\'à ce que les secousses cessent.'
                    : 'Pull over safely, away from bridges, tunnels and buildings.\nStay in the car until the shaking stops.',
                Icons.directions_car,
              ),

              // Section 7: Participe à aider
              _buildSection(
                selectedLanguage == 'Français' ? '8. Évite les escaliers et ascenseurs 🚷' : '8. Avoid stairs & elevators 🚷',
                selectedLanguage == 'Français'
                    ? 'Les escaliers pourraient s’effondrer et les ascenseurs pourraient se bloquer.'
                    : 'Stairs may collapse, and elevators could get stuck.',
                Icons.stairs,
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Retour à la page précédente
                  },
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
                  child: Text(selectedLanguage == 'Français' ? 'Retour à l\'Accueil' : 'Return to home page'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget qui construit une section stylisée avec un titre, une icône et du contenu textuel
  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Marge en bas de chaque section pour espacer les blocs
      padding: const EdgeInsets.all(16), // Padding interne pour ajouter de l'espace autour du contenu
      decoration: BoxDecoration(
        color: Colors.blue[50], // Couleur de fond bleu clair
        borderRadius: BorderRadius.circular(16), // Coins arrondis
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, // Couleur de l'ombre (noir clair)
            blurRadius: 5, // Rayon de flou de l'ombre
            offset: Offset(0, 3), // Décalage vertical de l'ombre
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligner les éléments à gauche
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