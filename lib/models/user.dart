import 'package:cloud_firestore/cloud_firestore.dart';

// Ce model représente les objets de type Utilisateur afin de pouvoir bien gérer nos utilisateurs et plus facilement
class User {
  bool? admin;
  String? email;
  String? fullname;
  int? joinDate;
  String? photoUrl;
  String? token;
  String? uid;
  List? followers;

  User({
    this.admin,
    this.email,
    this.fullname,
    this.joinDate,
    this.photoUrl,
    this.token,
    this.uid,
    this.followers,
  });

  User.fromJson(Map<String, dynamic> json) {
    admin = json["admin"];
    email = json["email"];
    fullname = json["fullname"];
    joinDate = json["joinDate"];
    photoUrl = json["photoUrl"];
    token = json["token"];
    uid = json["uid"];
    followers = json["followers"];
  }

  Map<String, dynamic> json() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["admin"] = admin;
    data["email"] = email;
    data["fullname"] = fullname;
    data["joinDate"] = joinDate;
    data["photoUrl"] = photoUrl;
    data["token"] = token;
    data["uid"] = uid;
    data["followers"] = followers;
    return data;

  }
}