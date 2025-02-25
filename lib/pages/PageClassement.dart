import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassementPage extends StatefulWidget {
  const ClassementPage({super.key});

  @override
  _ClassementPageState createState() => _ClassementPageState();
}

class _ClassementPageState extends State<ClassementPage> {
  String selectedAgeRange = "Tous";
  String selectedLanguage = "Français"; // Langue par défaut
  List<String> ageRanges = [];

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    ageRanges = [
      selectedLanguage == "Français" ? "Tous" : "All",
      "0-5", "6-10", "11-15", "16-20", "21-25",
      "26-30", "31-35", "36-40", "41-45", "46-50", "51+"
    ];
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

  //Cette fonction nous permet de récupérer les utilisateurs et de les classer selon leurs nombres de points et tranche d'âge
  Stream<QuerySnapshot> getUsersStream() {
    var query = FirebaseFirestore.instance
        .collection('users')
        .orderBy('points', descending: true);

    if (selectedAgeRange != "Tous") {
      List<String> rangeParts = selectedAgeRange.split('-');
      int minAge = int.parse(rangeParts[0]);
      int maxAge = rangeParts.length > 1 ? int.parse(rangeParts[1]) : 100;

      query = query.where("age", isGreaterThanOrEqualTo: minAge, isLessThanOrEqualTo: maxAge);
    }

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          selectedLanguage == 'Français' ? "Classement" : "Ranking",
          style: const TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
        actions: [
          DropdownButton<String>(
            value: selectedAgeRange,
            icon: const Icon(Icons.filter_list, color: Colors.black),
            underline: Container(),
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              setState(() {
                selectedAgeRange = newValue!;
              });
            },
            items: ageRanges.map<DropdownMenuItem<String>>((String range) {
              return DropdownMenuItem<String>(
                value: range,
                child: Text(range, style: const TextStyle(color: Colors.black, fontSize: 16)),
              );
            }).toList(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      //Streambuilder pour afficher le classement en temps réel
      body: StreamBuilder<QuerySnapshot>(
        stream: getUsersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var users = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              String fullName = user['fullname'] ?? 'Unknown';
              int points = user['points'] ?? 0;
              int age = user['age'] ?? 0;
              String avatar = user['photoUrl'] ?? 'assets/images/profil.png';

              Color medalColor;
              if (index == 0) {
                medalColor = Colors.amber[700]!;
              } else if (index == 1) {
                medalColor = Colors.grey;
              } else if (index == 2) {
                medalColor = Colors.brown[400]!;
              } else {
                medalColor = Colors.blueGrey;
              }

              return GestureDetector(
                onTap: () => _showUserDetails(context, fullName, points, age),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6DFC5),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: medalColor, size: 28),
                        const SizedBox(width: 12),
                        ClipOval(
                          child: Image.network(
                            avatar,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/images/profil.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fullName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                              Text("$age ${selectedLanguage == 'Français' ? 'ans' : 'years old'}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                            ],
                          ),
                        ),
                        Text(
                          '$points points',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //Boîte de dialogue affichant les détails des informations de l'utilisateur
  void _showUserDetails(BuildContext context, String fullName, int points, int age) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fullName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "$age ${selectedLanguage == 'Français' ? 'ans' : 'years old'}",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              Text(
                "$points points",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(selectedLanguage == "Français" ? "Fermer" : "Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}