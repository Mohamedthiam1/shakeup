import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réglages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Social Media Connect Section
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFC7E4BF),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(10),
                child: const Column(
                  children: [
                    Text(
                      'Connexion',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SocialButton(label: 'Google', iconPath: 'assets/icons8-google-48.png'),
                        SocialButton(label: 'Apple', iconPath: 'assets/icons8-apple-50.png'),
                        SocialButton(label: 'Facebook', iconPath: 'assets/icons8-facebook-48.png'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Toggle Settings
              const SettingToggle(title: 'Son'),
              const SettingToggle(title: 'Vibrations'),
              const SettingToggle(title: 'Musique'),
              const SettingToggle(title: 'Notifications'),

              // Language Dropdown
              const LanguageDropdown(),

              // Links and Other Options
              const SettingLink(title: 'Politique de confidentialité', routeName: '/privacy'),
              const SettingLink(title: 'Conditions d\'utilisation', routeName: '/terms'),
              const SettingLink(title: 'Support'),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for each social media button
class SocialButton extends StatelessWidget {
  final String label;
  final String iconPath;

  const SocialButton({super.key, required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min, // To make button fit content width
          children: [
            Image.asset(
              iconPath, // Display the custom icon
              width: 24, // Adjust size as needed
              height: 24,
            ),
            const SizedBox(width: 2), // Space between icon and text
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF36DD0C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
          child: const Text('Se connecter'),
        ),
      ],
    );
  }
}


// Widget for each toggle switch setting
class SettingToggle extends StatefulWidget {
  final String title;

  const SettingToggle({super.key, required this.title});

  @override
  _SettingToggleState createState() => _SettingToggleState();
}

class _SettingToggleState extends State<SettingToggle> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: const TextStyle(fontSize: 16)),
        Switch(
          value: isEnabled,
          onChanged: (value) {
            setState(() {
              isEnabled = value;
            });
          },
          activeColor: Colors.green,
        ),
      ],
    );
  }
}

// Widget for each link-style setting
class SettingLink extends StatelessWidget {
  final String title;
  final String? routeName;

  const SettingLink({super.key, required this.title, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          if (routeName != null) {
            Navigator.pushNamed(context, routeName!);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


// Dropdown for language selection
class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Langue', style: TextStyle(fontSize: 16)),
          DropdownButton<String>(
            value: selectedLanguage,
            items: <String>['Français', 'English'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}

// Privacy Policy Page
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de confidentialité'),
        backgroundColor: Colors.green[200],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'Contenu de la politique de confidentialité...',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// Terms and Conditions Page
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conditions d\'utilisation'),
        backgroundColor: Colors.green[200],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'Contenu des conditions d\'utilisation...',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}