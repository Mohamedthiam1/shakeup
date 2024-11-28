import 'package:flutter/material.dart';
import 'AdminStoryPage.dart';
import 'AdminQuizPage.dart';
import 'package:cap/pages/salon.dart'; // Assurez-vous que ce fichier existe

class AdminPrincipalPage extends StatelessWidget {
  const AdminPrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adminName = "OURARI Tinhinane"; // Exemple : nom de l'admin

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: Text("Tableau de Bord Administrateur",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // Section d'identité de l'administrateur
              GestureDetector(
                onTap: () {
                  _showAdminDetails(context, adminName);
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage('assets/images/profil.png'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      adminName,
                      style: const TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Options cliquables avec taille personnalisée
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Désactive le scroll interne
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 2.5, // Ajustez le rapport largeur/hauteur des éléments
                children: [
                  _buildOptionCard(
                    context,
                    title: 'Histoires',
                    icon: Icons.book,
                    color: Colors.orangeAccent,
                    destination: const AdminStoryPage(),
                  ),
                  _buildOptionCard(
                    context,
                    title: 'Quiz',
                    icon: Icons.quiz,
                    color: Colors.blueAccent,
                    destination: const AdminQuizPage(),
                  ),
                  _buildOptionCard(
                    context,
                    title: 'Salons',
                    icon: Icons.meeting_room,
                    color: Colors.greenAccent,
                    destination: const SalonPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Popup pour les détails de l'administrateur
  void _showAdminDetails(BuildContext context, String adminName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.teal.shade100, // Couleur claire basée sur AppBar
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Informations Administrateur',
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Nom et Prenom : $adminName',
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Fermer',
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
      },
    );
  }

  // Fonction pour créer les cartes d'options cliquables
  Widget _buildOptionCard(BuildContext context,
      {required String title,
        required IconData icon,
        required Color color,
        required Widget destination}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Arima',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
