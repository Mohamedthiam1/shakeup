import 'package:cap/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'following_screen.dart';

class SearchUserScreen extends StatefulWidget {
  final String currentUserId;

  const SearchUserScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  TextEditingController emailController = TextEditingController();
  User? searchedUser;
  bool isLoading = false;
  bool followsMe = false;

  //Fonction pour rechercher une adresse email par son adresse email sur Firestore
  Future<void> searchUserByEmail() async {
    String email = emailController.text.trim().toLowerCase();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer un email")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isNotEmpty) {
        setState(() {
          searchedUser = User.fromJson(query.docs.first.data() as Map<String, dynamic>);
          followsMe = searchedUser!.followers!.contains(widget.currentUserId);
        });
      } else {
        setState(() => searchedUser = null);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Utilisateur non trouvé")),
        );
      }
    } catch (e) {
      print("Erreur lors de la recherche : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la recherche")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  //Fonction pour ajouter un nouveau follower
  Future<void> addToFollowers() async {
    if (searchedUser == null || searchedUser!.uid == widget.currentUserId) return;

    try {
      DocumentReference currentUserRef =
      FirebaseFirestore.instance.collection('users').doc(widget.currentUserId);

      await currentUserRef.update({
        "followers": FieldValue.arrayUnion([searchedUser!.uid]),
      });

      setState(() {
        followsMe = !followsMe;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(!followsMe ? "Utilisateur retiré de vos amis !" : "Utilisateur ajouté à vos amis !")),
      );
    } catch (e) {
      print("Erreur lors de l'ajout aux followers : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l'ajout aux amis")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rechercher un utilisateur"),
      actions: [
        //Ce bouton nous renvoie vers la page des comptes que l'on suit déjà et voir ses amis
        TextButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FollowingScreen(currentUserId: sharedPreferences!.getString("uid")!),
            ),
          );
        },
            child: const Text("Voir mes amis", style: TextStyle(
              color: Colors.black,
              fontSize: 16
        )))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //TextField pour rentrer l'adresse email
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Entrer l'email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              //Bouton pour rechercher l'utilisateur
              ElevatedButton(
                onPressed: isLoading ? null : searchUserByEmail,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Rechercher"),
              ),
              const SizedBox(height: 20),
              //Si trouvé. nous affichons ici ses infos
              searchedUser != null
                  ? Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: searchedUser!.photoUrl != null
                        ? NetworkImage(searchedUser!.photoUrl!)
                        : null,
                    child: searchedUser!.photoUrl == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  title: Text(searchedUser!.fullname ?? "Utilisateur inconnu"),
                  subtitle: Text(searchedUser!.email ?? ""),
                  trailing: ElevatedButton(
                    onPressed: addToFollowers,
                    child: Text(followsMe ? "Ne plus suivre" : "Suivre"),
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}