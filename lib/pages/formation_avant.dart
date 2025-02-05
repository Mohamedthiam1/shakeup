import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//page d'informations "Avant un Séisme"
class AvantPage extends StatefulWidget {
  const AvantPage({super.key});

  @override
  State<AvantPage> createState() => _AvantPage(); // Récupération de la largeur de l'écran pour une mise en page réactive
}

class _AvantPage extends State<AvantPage> {
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpening(); // Vérifie si l'utilisateur ouvre la page pour la première fois
    _loadLanguage(); // Charger la langue au démarrage
  }

  // Charger la langue depuis SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language');
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  // Vérifie si c'est la première fois que l'utilisateur ouvre cette page
  Future<void> _checkFirstTimeOpening() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasOpenedBefore = prefs.getBool('opened_educational_file') ?? false;

    if (!hasOpenedBefore) {
      await prefs.setBool('opened_educational_file', true); // Enregistre l'ouverture
      _showBadgePopup(); // Affiche le pop-up de badge débloqué
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
        title: Text(selectedLanguage == 'Français' ? 'Avant un Séisme' : 'Before an Earthquake',
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
            crossAxisAlignment: CrossAxisAlignment.start, // Contenu aligné à gauche
            children: [
              // Section 1: Comprendre les tremblements de terre
              _buildSection(
                selectedLanguage == 'Français'
                    ? '1. Qu’est-ce qu’un tremblement de terre ? 🌍'
                    : '1. What is an Earthquake? 🌍',
                selectedLanguage == 'Français'
                    ? 'Un tremblement de terre, c’est quand la Terre bouge ! Cela arrive \n parce que des plaques sous le sol glissent. Pas de panique, on peut apprendre à se protéger !'
                    : 'An earthquake is when the Earth moves ! It happens \n because plates under the ground are sliding. Don\'t panic, you can learn to protect yourself !',
                Icons.emoji_nature,
                selectedLanguage == 'Français'
                    ? 'La Terre est vivante et parfois elle danse ! 🌍✨'
                    : 'The Earth is alive and sometimes it dances ! 🌍✨',
              ),

              // Section 2: Construire un kit d'urgence
              _buildSection(
                  selectedLanguage == 'Français'
                      ? '2. Fabrique ton kit d’urgence 🎒'
                      : '2. Make your emergency kit 🎒',
                  selectedLanguage == 'Français'
                      ? 'Un sac magique pour être prêt en cas d’urgence ! Ajoute ces objets :'
                      : 'A magic bag to be prepared in case of emergency! Add these items:',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.flashlight_on, 'text': selectedLanguage == 'Français' ? 'Une lampe de poche pour voir dans le noir.' : 'A flashlight to see in the dark.'},
                    {'icon': Icons.medical_services, 'text': selectedLanguage == 'Français' ? 'Une trousse de secours pour soigner les petits bobos.' : 'A first aid kit to treat minor injuries.'},
                    {'icon': Icons.water_drop, 'text': selectedLanguage == 'Français' ? 'De l’eau pour rester hydraté.' : 'Water to stay hydrated.'},
                    {'icon': Icons.cookie, 'text': selectedLanguage == 'Français' ? 'Des snacks pour avoir de l’énergie.' : 'Snacks for energy.'},
                    {'icon': Icons.bed, 'text': selectedLanguage == 'Français' ? 'Une couverture pour rester au chaud.' : 'A blanket to stay warm.'},
                    {'icon': Icons.volume_up, 'text': selectedLanguage == 'Français' ? 'Un sifflet pour appeler à l’aide.' : 'A whistle to call for help.'},
                  ]
              ),

              // Section 3: Les gestes qui sauvent
              _buildSection(
                  selectedLanguage == 'Français' ? '3. Les gestes qui sauvent 🚨' : '3. Life-saving actions 🚨',
                  selectedLanguage == 'Français' ? 'Apprends ces 3 gestes importants pour te protéger :' : 'Learn these 3 important actions to protect yourself:',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.pan_tool, 'text': selectedLanguage == 'Français' ? '1. Baisse-toi pour éviter de tomber.' : '1. Drop to avoid falling.'},
                    {'icon': Icons.shield, 'text': selectedLanguage == 'Français' ? '2. Cache-toi sous une table solide.' : '2. Hide under a sturdy table.'},
                    {'icon': Icons.handshake, 'text': selectedLanguage == 'Français' ? '3. Accroche-toi jusqu’à ce que ça s’arrête.' : '3. Hold on until it stops.'},
                  ]
              ),

              // Section 4: Préparer sa maison
              _buildSection(
                  selectedLanguage == 'Français' ? '4. Rends ta maison plus sûre 🏡' : '4. Make your home safer 🏡',
                  selectedLanguage == 'Français' ? 'Voici comment sécuriser ta maison :' : 'Here’s how to secure your home:',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.lock, 'text': selectedLanguage == 'Français' ? 'Demande à un adulte de fixer les meubles lourds au mur.' : 'Ask an adult to anchor heavy furniture to the wall.'},
                    {'icon': Icons.cleaning_services, 'text': selectedLanguage == 'Français' ? 'Range les objets fragiles et les jouets sous les étagères.' : 'Store fragile items and toys under shelves.'},
                    {'icon': Icons.search, 'text': selectedLanguage == 'Français' ? 'Repère les coins sûrs où tu peux te cacher (comme sous une table).' : 'Identify safe corners where you can hide (like under a table).'},
                    {'icon': Icons.delete, 'text': selectedLanguage == 'Français' ? 'Ramasse les jouets qui traînent pour ne pas que quelqu’un tombe.' : 'Pick up toys lying around to avoid tripping.'},
                    {'icon': Icons.check_circle, 'text': selectedLanguage == 'Français' ? 'Vérifie que rien ne bloque la sortie d’urgence.' : 'Check that nothing blocks the emergency exit.'},
                    {'icon': Icons.add, 'text': selectedLanguage == 'Français' ? 'Étiquette ton kit d’urgence pour savoir où il est en cas de besoin.' : 'Label your emergency kit so you know where it is in case of need.'},
                  ]
              ),

              // Section 5: Numéros d'urgence
              _buildSection(
                  selectedLanguage == 'Français' ? '5. Les numéros importants à retenir 📞' : '5. Important emergency numbers to remember 📞',
                  selectedLanguage == 'Français' ? 'Garde ces numéros à portée de main :' : 'Keep these numbers handy:',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.fire_extinguisher, 'text': selectedLanguage == 'Français' ? 'Pompiers : 18' : 'Fire department: 18'},
                    {'icon': Icons.local_police, 'text': selectedLanguage == 'Français' ? 'Police : 17' : 'Police: 17'},
                    {'icon': Icons.health_and_safety, 'text': selectedLanguage == 'Français' ? 'Urgences médicales : 15' : 'Medical emergency: 15'},
                    {'icon': Icons.phone, 'text': selectedLanguage == 'Français' ? 'Ajoute le numéro de ta famille.' : 'Add your family’s phone number.'},
                  ]
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Retour à la page précédente
                  },
                  child: Text(selectedLanguage == 'Français' ? 'Retour à l\'Accueil' : 'Return to Home'),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  // Fonction utilitaire pour créer une section avec un titre, un contenu et des icônes
  Widget _buildSection(
      String title,
      String content,
      IconData? icon,
      String? iconText, {
        List<Map<String, dynamic>>? listItems,
      }) {
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
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          if (icon != null && iconText != null) ...[
            const SizedBox(height: 10),
            _iconWithText(icon, iconText),
          ],
          if (listItems != null) ...[
            const SizedBox(height: 10),
            _listItemsWithIcons(listItems),
          ],
        ],
      ),
    );
  }

  // Widget pour afficher une liste d'éléments avec des icônes
  Widget _iconWithText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 32, color: Colors.green),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _listItemsWithIcons(List<Map<String, dynamic>> items) {
    return Column(
      children: items.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item['icon'], color: Colors.blueAccent, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item['text'],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
