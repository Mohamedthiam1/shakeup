import 'dart:math';

import 'package:cap/pages/test-quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import 'home_page.dart';

//Salon = équipe

class SalonPage extends StatefulWidget {
  const SalonPage({super.key});

  @override
  State<SalonPage> createState() => _SalonPageState();
}

// Page pour gérer les équipes : création ou connexion
class _SalonPageState extends State<SalonPage> {
  late TextEditingController roomName; //nom de l'équipe
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    roomName = TextEditingController(); // Initialisation du TextEditingController
    _loadLanguage(); // Charger la langue au démarrage
  }

  @override
  void dispose() {
    roomName.dispose(); // Libération de la mémoire du contrôleur lorsque le widget est supprimé
    super.dispose();
  }

  // Méthode pour récupérer la langue depuis SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language'); // Vérifie s'il y a une langue sauvegardée
    if (language != null && mounted) { // Vérifie si le widget est toujours actif avant d'appeler setState
      setState(() {
        selectedLanguage = language; // Met à jour la langue sélectionnée
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: Text(
          selectedLanguage == "Français" ? "Équipes" : "Teams", // Titre affiché dans la barre d'application
          style: const TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100], // Couleur de fond verte claire
        centerTitle: true, // Centrer le titre dans l'AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Centrage vertical des cadres (au milieu de la page)
          children: [
            // Bouton "Créer une équipe"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, // 60% de la largeur de l'écran
              child: SalonButton(
                title: selectedLanguage == "Français" ? "Créer une équipe" : "Create a team",
                onPressed: () => showCreateSalonDialog(context), // Afficher la popup pour créer une équipe
              ),
            ),

            const SizedBox(height: 10), // Espacement entre les deux cadres

            // Bouton "Rejoindre une équipe"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, // 60% de la largeur de l'écran
              child: SalonButton(
                title: selectedLanguage == "Français" ? "Rejoindre une équipe" : "Join a team",
                onPressed: () => showJoinSalonDialog(context), // Afficher la popup pour créer une équipe
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(), // Footer en bas
    );
  }

  // Fonction pour créer un équipe et sauvegarder les données dans Firestore et SharedPreferences
  Future createSalonAndSaveData(BuildContext context, StateSetter setState) async {
    String roomCode = generateRandomCode(8); // Génère un code d'équipe aléatoire

    // Créer une équipe dans Firestore avec le code d'équipe, le nom du professeur et la difficulté
    await FirebaseFirestore.instance.collection("salons").doc(roomCode).set({
      'roomCode': roomCode,
      'roomName': roomName.text, // Nom de l'équipe
      'participants': [], // Liste vide pour les participants
    }).whenComplete(() async {
      // Une fois que l'ajout Firestore est terminé, nous stockons les valeurs dans sharedPreferences
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences!.setString("roomCode", roomCode);
      await sharedPreferences!.setString("roomName", roomName.text);

      setState(() {
        sharedPreferences; // Met à jour l'état avec les nouvelles données
      });

      // Naviguer vers une autre page ou afficher un message de succès
      showToast("Équipe créé avec succès !");
      // Naviguer vers la page des participants
      Navigator.of(context).pop(); // Ferme le popup
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ParticipantsPage(
                roomNumber: roomCode, // Passer le code généré comme numéro d'équipe
                roomName: roomName.text // Passer le nom du professeur
              ),
        ),
      );
    }).catchError((e) {
      // Si une erreur survient, on peut afficher un message d'erreur
      showToast("Erreur lors de la création de l'équipe: $e");
    });
  }

  // Popup pour créer une équipe (demande nom professeur et niveau de difficulté)
  void showCreateSalonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Arrondir les bords du dialog
              ),
              child: SingleChildScrollView(  // Permet de défiler si le contenu dépasse l'écran
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200), // Largeur maximale du cadre
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Ne pas occuper plus de place que nécessaire
                      children: [
                        Text(
                          selectedLanguage == "Français" ? "Créer une équipe" : "Create a team",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: roomName, // Le contrôleur pour le champ texte
                          decoration: InputDecoration(
                            labelText: selectedLanguage == "Français" ? "Nom de l'équipe" : "Team name",
                            border: OutlineInputBorder(), // Bordure du champ texte
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Dropdown pour sélectionner la difficulté

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(selectedLanguage == "Français" ? "Annuler" : "Cancel"),
                              onPressed: () => Navigator.of(context).pop(), // Fermer le popup
                            ),
                            ElevatedButton(
                              child: Text(selectedLanguage == "Français" ? "Créer" : "Create"),
                              onPressed: () async {
                                await createSalonAndSaveData(context, setState); // Créer l'équipe
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  // Popup pour rejoindre une équipe (bouton rejoindre) : demande le numéro de salle
  void showJoinSalonDialog(BuildContext context) {
    final TextEditingController roomController = TextEditingController(); // Boîte pour récupérer le numéro de la salle
    final TextEditingController playerNameController = TextEditingController(); // Boîte pour récupérer le nom du joueur

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Forme du dialog avec coins arrondis
          child: SingleChildScrollView(  // Permet de défiler le contenu si nécessaire
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200), // Largeur maximale du cadre
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Pas plus large que nécessaire
                  children: [
                    Text(
                      selectedLanguage == "Français" ? "Rejoindre une équipe" : "Join a team",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 16),
                    // Champ pour entrer le nom du joueur
                    TextField(
                      controller: playerNameController,
                      decoration: InputDecoration(
                        labelText: selectedLanguage == "Français" ? "Nom du joueur" : "Player name",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Champ pour entrer le numéro d'équipe
                    TextField(
                      controller: roomController,
                      decoration: InputDecoration(
                        labelText: selectedLanguage == "Français" ? "Numéro de l'équipe" : "Team number",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text, // Type de clavier texte
                    ),
                    const SizedBox(height: 24),

                    // Actions des boutons (Annuler et Rejoindre)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(selectedLanguage == "Français" ? "Annuler" : "Cancel"),
                          onPressed: () => Navigator.of(context).pop(), // Fermer la popup
                        ),
                        ElevatedButton(
                          child: Text(selectedLanguage == "Français" ? "Rejoindre" : "Join"),
                          onPressed: () async {
                            String roomCode = roomController.text;
                            String playerName = playerNameController.text;

                            var salonSnapshot = await FirebaseFirestore.instance
                                .collection("salons")
                                .doc(roomCode)
                                .get();

                            if (salonSnapshot.exists) {
                              String roomName = salonSnapshot['roomName'];

                              if (context.mounted) { // Vérifie si le widget est encore actif
                                joinSalon(context, roomCode, playerName, roomName);

                                Navigator.of(context).pop(); // Fermer la popup
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ParticipantsPage(roomNumber: roomCode, // Passer le code d'équipe
                                          roomName: roomName, // Passer le nom du professeur
                                        ),
                                  ),
                                );
                              }
                            } else {
                              // Si l'équipe n'existe pas, afficher un message d'erreur
                              showToast("Salon introuvable ! Vérifiez le numéro de la salle.");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Fonction pour rejoindre une équipe
  void joinSalon(BuildContext context, String roomNumber, String playerName, String roomName) async {
    final salonRef = FirebaseFirestore.instance.collection('salons').doc(roomNumber);

    try {
      // Ajouter le nom du joueur dans la liste des participants
      await salonRef.update({
        'participants': FieldValue.arrayUnion([playerName]),
      });

      // Si l'ajout est effectué avec succès, tu peux naviguer vers la page des participants
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParticipantsPage(
                roomNumber: roomNumber,
                roomName: roomName,
              ),
        ),
      );
    } catch (e) {
      // Si une erreur survient, afficher un message d'erreur
      showToast("Erreur lors de la connexion à l'équipe: $e");
    }
  }
}

// Cadres boutons pour "Créer une équipe" and "Rejoindre une équipe"
class SalonButton extends StatelessWidget {
  final String title; // Titre du bouton
  final VoidCallback onPressed; // Action au clic

  const SalonButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF2D2B1), // Couleur de fond rose-orange
        padding: const EdgeInsets.symmetric(vertical: 15), // Espacement interne
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Coins arrondis
          side: const BorderSide(color: Colors.black), // Bordure noire
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Expanded(
            child: Center(
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
        ],
      ),
    );
  }
}

// Page des participants en attente
class ParticipantsPage extends StatefulWidget {
  final String roomNumber;
  final String roomName;

  const ParticipantsPage({
    super.key,
    required this.roomNumber,
    required this.roomName
  });

  @override
  _ParticipantsPageState createState() => _ParticipantsPageState();
}


// État de la page des participants
class _ParticipantsPageState extends State<ParticipantsPage> {
  late String roomName;
  late String roomNumber;
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    roomName = widget.roomName; // Récupérer le nom du professeur depuis les paramètres
    roomNumber = widget.roomNumber; // Récupérer le numéro d'équipe depuis les paramètres
    _loadLanguage(); // Charger la langue au démarrage
  }

  // Méthode pour récupérer la langue depuis SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language'); // Vérifie s'il y a une langue sauvegardée
    if (language != null) {
      setState(() {
        selectedLanguage = language; // Met à jour la langue sélectionnée
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text("Participants", // Titre de la page
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // En-tête avec le nom du professeur et le numéro de salle
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedLanguage == "Français" ? "Nom d'équipe" : "Team Name",
                    style: const TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    selectedLanguage == "Français" ? "N° d'équipe": "Team number",
                    style: TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
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
                  Text(
                    roomName, // Affiche le nom du professeur
                    style: const TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    roomNumber, // Affiche le numéro de la salle
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
            //const SizedBox(height: 10),

            // Liste des participants
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Participants :',
                      style: TextStyle(
                        fontFamily: 'Arima',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    //const SizedBox(height: 10),

                    // Récupérer et afficher la liste des participants en temps réel
                    StreamBuilder<DocumentSnapshot>(
                      // Écoute en temps réel les changements du document correspondant au numéro de salle
                      stream: FirebaseFirestore.instance.collection('salons').doc(roomNumber).snapshots(),
                      builder: (context, snapshot) {
                        // Si les données ne sont pas encore disponibles, afficher un indicateur de chargement
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // Récupérer les données du document sous forme de Map
                        var data = snapshot.data!.data() as Map<String, dynamic>?;
                        // Extraire la liste des participants (si elle existe)
                        var participants = data?['participants'] as List<dynamic>?;

                        // Vérifier si la liste est vide ou inexistante
                        if (participants == null || participants.isEmpty) {
                          return Text(selectedLanguage == "Français" ? "Aucun participant n'est dans cette équipe." : "There are no participants in this team.");
                        }

                        // Si des participants sont présents, les afficher dans une liste
                        return Expanded(  // Permet d'éviter l'espace inutile et fait le scroll dans participants
                            child: ListView.builder(
                              shrinkWrap: true, // Empêche la liste de prendre tout l'espace disponible
                              itemCount: participants.length, // Nombre d'éléments dans la liste
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(participants[index]),// Affiche le nom de chaque participant
                                );
                            },
                          ),
                        );
                      },
                    ),

                    //const SizedBox(height: 10),

                    // Bouton "Start" pour démarrer le quiz
                    Align(
                      alignment: Alignment.bottomRight, // Bouton placé en bas à droite
                      child: ElevatedButton(
                        onPressed: () {
                          // Lorsqu'on appuie sur le bouton, on navigue vers la page du quiz
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const QuizPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF6DFC5), // Couleur de fond
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)), // Coins arrondis
                            side: BorderSide(color: Colors.black, width: 1), // Bord noir
                          ),
                          minimumSize: const Size(60, 30), // Taille du bouton
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Espacement interne
                        ),
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Arima',
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
          ],
        ),
      ),
    );
  }
}

// Fonction pour générer un code aléatoire
String generateRandomCode(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyz'; // Liste des caractères possibles (minuscules uniquement)
  Random random = Random(); // Générateur de nombres aléatoires
  // Génère une liste de caractères aléatoires de la longueur spécifiée, puis les joint en une chaîne
  return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
}
