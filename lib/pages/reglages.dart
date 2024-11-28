import 'package:flutter/material.dart';

// Page des paramètres de l'appli
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Largeur de l'écran pour adapter les marges et tailles

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: Text("Réglages",
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
        padding: const EdgeInsets.all(16.0), // Marges autour du contenu principal
        child: SizedBox(
          width: width, // Largeur du contenu alignée à l'écran
          child: SingleChildScrollView(
            // Permet le défilement si le contenu dépasse la taille de l'écran
            child: Container(
              alignment: Alignment.center, // Centre tout le contenu horizontalement
              margin: EdgeInsets.symmetric(horizontal: width * 0.03), // Marges latérales dynamiques

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centre tous les enfants de manière horizontale
                children: [

                  // Section pour la connexion via les réseaux sociaux
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFC7E4BF), // Fond vert clair
                      borderRadius: BorderRadius.circular(15), // Coins arrondis
                    ),
                    padding: const EdgeInsets.all(10), // Espacement interne
                    child: const Column(
                      children: [
                        Text(
                          'Connexion',
                          style: TextStyle(
                            fontFamily: 'Arima',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10), // Espacement
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribution égale des boutons
                          children: [
                            SocialButton(label: 'Google', iconPath: 'assets/images/icons8-google-48.png'),
                            SocialButton(label: 'Apple', iconPath: 'assets/images/icons8-apple-50.png'),
                            SocialButton(label: 'Facebook', iconPath: 'assets/images/icons8-facebook-48.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Options de réglages avec des interrupteurs
                  const SettingToggle(title: 'Son'),
                  const SettingToggle(title: 'Vibrations'),
                  const SettingToggle(title: 'Musique'),
                  const SettingToggle(title: 'Notifications'),

                  // Menu déroulant pour le choix de la langue
                  const LanguageDropdown(),

                  // Liens vers d'autres pages
                  const SettingLink(title: 'Politique de confidentialité', routeName: '/privacy'),
                  const SettingLink(title: 'Conditions d\'utilisation', routeName: '/terms'),
                  const SettingLink(title: 'Support'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Bouton pour les réseaux sociaux
class SocialButton extends StatelessWidget {
  final String label; // Texte affiché sur le bouton
  final String iconPath; // Chemin de l'icône

  const SocialButton({super.key, required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min, // Ajuste la taille pour correspondre au contenu
          children: [
            Image.asset(
              iconPath, // Affiche l'icône
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 2), // Espacement entre l'icône et le texte
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Arima',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {}, // Action à définir lors de l'appui sur le bouton
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF36DD0C), // Couleur verte
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Coins arrondis
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Espacement interne
          ),
          child: const Text('Se connecter',
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}


// Interrupteur pour activer/désactiver une fonctionnalité (carré où on coche)
class SettingToggle extends StatefulWidget {
  final String title; // Titre de l'option

  const SettingToggle({super.key, required this.title});

  @override
  _SettingToggleState createState() => _SettingToggleState();
}

class _SettingToggleState extends State<SettingToggle> {
  bool isEnabled = true; // État initial de l'interrupteur

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribution des éléments
      children: [
        Text(widget.title, style: const TextStyle(
          fontFamily: 'Arima',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        )
        ),
        Switch(
          value: isEnabled, // État actuel de l'interrupteur
          onChanged: (value) {
            setState(() {
              isEnabled = value; // Change l'état de l'interrupteur
            });
          },
          activeColor: Colors.green, // Couleur lorsque l'interrupteur est activé
        ),
      ],
    );
  }
}

// Liens pour accéder à d'autres pages
class SettingLink extends StatelessWidget {
  final String title; // Titre du lien
  final String? routeName; // Nom de la route pour la navigation

  const SettingLink({super.key, required this.title, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Espacement vertical
      child: InkWell(
        onTap: () {
          if (routeName != null) {
            Navigator.pushNamed(context, routeName!); // Navigation vers une autre page
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Marges internes
          decoration: BoxDecoration(
            color: Colors.green[100], // Couleur de fond
            borderRadius: BorderRadius.circular(10), // Coins arrondis
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}


// Menu déroulant pour sélectionner la langue
class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacement vertical
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribution des éléments
        children: [
          const Text('Langue',
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),

          DropdownButton<String>(
            value: selectedLanguage, // Langue actuelle sélectionnée
            items: <String>['Français', 'English'].map((String value) {
              return DropdownMenuItem<String>(
                value: value, // Valeur de l'élément
                child: Text(value), // Texte affiché dans le menu déroulant
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedLanguage = newValue!; // Change la langue sélectionnée
              });
            },
          ),
        ],
      ),
    );
  }
}

// Page politique de confidentialité
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
        title: Text('Politique de confidentialité',
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

      body: const Padding(
        padding: EdgeInsets.all(16.0), // Espacement autour du contenu principal
        child: SingleChildScrollView(
          // Permet le défilement si le texte est trop long pour l'écran
          child: Text(
            'Contenu de la politique de confidentialité...',
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// Page conditions d'utilisation
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

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
        title: Text('Conditions d\'utilisation',
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
      body: const Padding(
        padding: EdgeInsets.all(16.0), // Marges autour du contenu
        child: SingleChildScrollView(
          // Permet de défiler pour voir tout le contenu
          child: Text(
            'Contenu des conditions d\'utilisation...',
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}