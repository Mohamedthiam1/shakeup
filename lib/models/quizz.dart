import 'package:cloud_firestore/cloud_firestore.dart';

// Ce model représente les objets de type Quizz
class Quizz {
  List? answers;
  int? correctOne;
  Timestamp? created;
  String? pictureUrl;
  String? question;
  String? quizzID;
  String? whoSubmitted;

  Quizz({
    this.answers,
    this.correctOne,
    this.created,
    this.pictureUrl,
    this.question,
    this.quizzID,
    this.whoSubmitted
  });

  Quizz.fromJson(Map<String, dynamic> json) {
    answers = json["answers"];
    correctOne = json["correctOne"];
    created = json["created"];
    pictureUrl = json["pictureUrl"];
    question = json["question"];
    quizzID = json["quizzID"];
    whoSubmitted = json["whoSubmitted"];
  }

  Map<String, dynamic> json() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["answers"] = answers;
    data["correctOne"] = correctOne;
    data["created"] = created;
    data["pictureUrl"] = pictureUrl;
    data["question"] = question;
    data["quizzID"] = quizzID;
    data["whoSubmitted"] = whoSubmitted;
    return data;

  }
}