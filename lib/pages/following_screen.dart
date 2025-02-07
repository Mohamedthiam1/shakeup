import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class FollowingScreen extends StatefulWidget {
  final String currentUserId;

  const FollowingScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  List<User> followingUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFollowingUsers();
  }

  Future<void> fetchFollowingUsers() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .get();

      List<String> followingIds = List<String>.from(userDoc.get("followers") ?? []);

      if (followingIds.isNotEmpty) {
        QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId, whereIn: followingIds)
            .get();

        setState(() {
          followingUsers = usersSnapshot.docs
              .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
        });
      }
    } catch (e) {
      print("Erreur lors de la récupération des abonnements : $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> removeFromFollowers(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .update({
        "followers": FieldValue.arrayRemove([userId])
      });

      setState(() {
        followingUsers.removeWhere((user) => user.uid == userId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Utilisateur retiré de votre liste d'amis")),
      );
    } catch (e) {
      print("Erreur lors du désabonnement : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors du désabonnement")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes Amis")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : followingUsers.isEmpty
          ? const Center(child: Text("Vous ne suivez personne pour le moment"))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: followingUsers.length,
        itemBuilder: (context, index) {
          User user = followingUsers[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: user.photoUrl != null
                    ? NetworkImage(user.photoUrl!)
                    : null,
                child: user.photoUrl == null ? const Icon(Icons.person) : null,
              ),
              title: Text(user.fullname ?? "Utilisateur inconnu"),
              subtitle: Text(user.email ?? ""),
              trailing: ElevatedButton(
                onPressed: () => removeFromFollowers(user.uid!),
                child: const Text("Ne plus suivre"),
              ),
            ),
          );
        },
      ),
    );
  }
}