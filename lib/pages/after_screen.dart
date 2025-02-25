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
          title: const Row(
            children: [
              Icon(Icons.search, color: Colors.blue, size: 40),
              SizedBox(width: 10),
              Text("Badge Débloqué !"),
            ],
          ),
          content: const Text(
            "Félicitations ! Tu as obtenu le badge \"Chercheur débutant\".",
            style: TextStyle(fontSize: 16),
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
                '1. Vérifie si tout va bien 😊',
                'Regarde autour de toi pour voir si tout le monde va bien. Si quelqu’un est blessé, dis-le à un adulte.',
                Icons.favorite,
              ),

              // Section 2: Reste loin des endroits dangereux
              _buildSection(
                '2. Éloigne-toi des dangers 🚧',
                'N\'approche pas des murs cassés, des objets qui pourraient tomber, ou des câbles électriques.',
                Icons.dangerous,
              ),

              // Section 3: Appelle un adulte si besoin
              _buildSection(
                '3. Demande de l’aide 📞',
                'Si tu es perdu ou as besoin d\'aide, appelle un adulte ou les secours. Explique où tu es.',
                Icons.phone,
              ),

              // Section 4: Écoute les consignes
              _buildSection(
                '4. Écoute les grandes personnes 👂',
                'Les adultes vont te dire quoi faire. Reste avec eux et écoute leurs conseils.',
                Icons.record_voice_over,
              ),

              // Section 5: Reste calme
              _buildSection(
                '5. Reste calme 🧘',
                'Si tu as peur, respire doucement et rappelle-toi que les secours vont venir t’aider.',
                Icons.self_improvement,
              ),

              // Section 6: Ne retourne pas tout de suite à la maison
              _buildSection(
                '6. N\'entre pas tout de suite chez toi 🏠',
                'Attends qu’un adulte vérifie que tout est sûr avant d’aller à l’intérieur.',
                Icons.house_siding,
              ),

              // Section 7: Participe à aider
              _buildSection(
                '7. Aide si tu peux 🤝',
                'Si les grandes personnes te le demandent, aide-les à ranger ou à donner des choses utiles.',
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
                  child: const Text('Retour à l\'Accueil'),
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
