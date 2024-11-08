import 'package:flutter/material.dart';

class FichePage extends StatelessWidget {
  const FichePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Fiches'),
        backgroundColor: Colors.green[200],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tab section
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Center(
              child: Text(
                "Fiches",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Card buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                InfoCard(
                  title: "Avant",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AvantPage()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const InfoCard(title: "Pendant"),
                const SizedBox(height: 10),
                const InfoCard(title: "Après"),
              ],
            ),
          ),
          const Spacer(),

          // Bottom navigation
          //const BottomNavigationBarWidget(),
        ],
      ),
    );
  }
}


// Card widget for "Avant", "Pendant", "Après"
class InfoCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const InfoCard({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF6DFC5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}


// New page for "Avant"
class AvantPage extends StatelessWidget {
  const AvantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Précautions Avant un Séisme"),
        backgroundColor: Colors.green[300],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Précautions à prendre avant un séisme",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "- Établissez un plan de secours familial et choisissez un lieu sûr où se rassembler après le séisme.\n"
                    "- Assurez-vous que les meubles lourds sont bien fixés aux murs.\n"
                    "- Repérez les zones sécurisées dans chaque pièce (sous des meubles solides, loin des fenêtres).\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Préparez un kit de secours avec des provisions essentielles : eau, nourriture, lampe de poche, médicaments, etc.\n"
                    "- Informez-vous des procédures d’évacuation et des numéros d’urgence.",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}