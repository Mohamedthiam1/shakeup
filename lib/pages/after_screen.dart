import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//page d'informations "Après un Séisme"
class After_Screen extends StatefulWidget {
  const After_Screen({super.key});

  @override
  State<After_Screen> createState() => _After_ScreenState(); // Récupération de la largeur de l'écran pour une mise en page réactive
}

class _After_ScreenState extends State<After_Screen> {
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
        title: Text(selectedLanguage == 'Français' ? 'Après le tremblement de terre' : 'After the earthquake',
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
                selectedLanguage == 'Français'
                    ? '1. Vérifie si tout va bien 😊'
                    : '1. Check if everyone is okay 😊',
                selectedLanguage == 'Français'
                    ? 'Regarde autour de toi pour voir si tout le monde va bien. Si quelqu’un est blessé, dis-le à un adulte.'
                    : 'Look around to see if everyone is okay. If someone is hurt, tell an adult.',
                Icons.favorite,
              ),

              // Section 2: Reste loin des endroits dangereux
              _buildSection(
                selectedLanguage == 'Français'
                    ? '2. Éloigne-toi des dangers 🚧'
                    : '2. Stay away from dangers 🚧',
                selectedLanguage == 'Français'
                    ? 'N\'approche pas des murs cassés, des objets qui pourraient tomber, ou des câbles électriques.'
                    : 'Don’t go near broken walls, objects that could fall, or electrical wires.',
                Icons.dangerous,
              ),

              // Section 3: Appelle un adulte si besoin
              _buildSection(
                selectedLanguage == 'Français'
                    ? '3. Demande de l’aide 📞'
                    : '3. Ask for help 📞',
                selectedLanguage == 'Français'
                    ? 'Si tu es perdu ou as besoin d\'aide, appelle un adulte ou les secours. Explique où tu es.'
                    : 'If you are lost or need help, call an adult or emergency services. Explain where you are.',
                Icons.phone,
              ),

              // Section 4: Écoute les consignes
              _buildSection(
                selectedLanguage == 'Français'
                    ? '4. Écoute les grandes personnes 👂'
                    : '4. Listen to adults 👂',
                selectedLanguage == 'Français'
                    ? 'Les adultes vont te dire quoi faire. Reste avec eux et écoute leurs conseils.'
                    : 'Adults will tell you what to do. Stay with them and follow their advice.',
                Icons.record_voice_over,
              ),

              // Section 5: Reste calme
              _buildSection(
                selectedLanguage == 'Français'
                    ? '5. Reste calme 🧘'
                    : '5. Stay calm 🧘',
                selectedLanguage == 'Français'
                    ? 'Si tu as peur, respire doucement et rappelle-toi que les secours vont venir t’aider.'
                    : 'If you are scared, breathe slowly and remember that help is on the way.',
                Icons.self_improvement,
              ),

              // Section 6: Ne retourne pas tout de suite à la maison
              _buildSection(
                selectedLanguage == 'Français'
                    ? '6. N\'entre pas tout de suite chez toi 🏠'
                    : '6. Don’t go inside your house right away 🏠',
                selectedLanguage == 'Français'
                    ? 'Attends qu’un adulte vérifie que tout est sûr avant d’aller à l’intérieur.'
                    : 'Wait for an adult to check if it is safe before going inside.',
                Icons.house_siding,
              ),

              // Section 7: Participe à aider
              _buildSection(
                selectedLanguage == 'Français'
                    ? '7. Aide si tu peux 🤝'
                    : '7. Help if you can 🤝',
                selectedLanguage == 'Français'
                    ? 'Si les grandes personnes te le demandent, aide-les à ranger ou à donner des choses utiles.'
                    : 'If adults ask you to, help clean up or share useful items.',
                Icons.handshake,
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
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
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
