import 'package:flutter/material.dart';

class SalonPage extends StatelessWidget {
  const SalonPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salons'),
        backgroundColor: Colors.green[200],
      ),
      body: Container(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Container(
                    color: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Center(
                      child: Text(
                        'Salons',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // "Créer un salon" button
                  SalonButton(
                    title: '     Créer un salon',
                    onPressed: () => showCreateSalonDialog(context),
                  ),
                  const SizedBox(height: 10),

                  // "Rejoindre un salon" button
                  SalonButton(
                    title: '     Rejoindre un salon',
                    onPressed: () => showJoinSalonDialog(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Popup to create a salon (asking for professor's name)
  void showCreateSalonDialog(BuildContext context) {
    final TextEditingController professorController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Créer un salon'),
          content: TextField(
            controller: professorController,
            decoration: const InputDecoration(
              labelText: 'Nom du professeur',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Créer'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ParticipantsPage(
                      roomNumber: 'Nouvelle Salle',
                      professorName: professorController.text,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Popup to join a salon (asking for room number)
  void showJoinSalonDialog(BuildContext context) {
    final TextEditingController roomController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rejoindre un salon'),
          content: TextField(
            controller: roomController,
            decoration: const InputDecoration(
              labelText: 'Numéro de sallon',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Rejoindre'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ParticipantsPage(
                      roomNumber: roomController.text,
                      professorName: '',
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// Button widget for "Créer un salon" and "Rejoindre un salon"
class SalonButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SalonButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF2D2B1),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.black),
        ],
      ),
    );
  }
}

// Participants Page (to display participants based on room number and professor name)
class ParticipantsPage extends StatelessWidget {
  final String roomNumber;
  final String professorName;

  const ParticipantsPage({super.key, required this.roomNumber, required this.professorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Participants'),
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with professor name and room number
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nom du professeur',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'N° de salle',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(professorName),
                  Text(roomNumber),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Participants list placeholder
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(8),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Participants :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Aucun participant trouvé pour cette salle."),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}