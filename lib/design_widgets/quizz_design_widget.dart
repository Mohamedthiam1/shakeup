import 'package:cap/models/quizz.dart';
import 'package:cap/widgets/showloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizzDesignWidget extends StatefulWidget {
  Quizz model;
  BuildContext context;
  QuizzDesignWidget({super.key, required this.context, required this.model});

  @override
  State<QuizzDesignWidget> createState() => _QuizzDesignWidgetState();
}

class _QuizzDesignWidgetState extends State<QuizzDesignWidget> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10, top: 5),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage(widget.model.pictureUrl!), fit: BoxFit.cover)
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.model.question!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          for (int i = 0; i < widget.model.answers!.length; i++)
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14.5, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "${i + 1} - ${widget.model.answers![i]}",
                    ),
                    if (i == widget.model.correctOne) // Correct answer check
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 18),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Confirmer la suppression",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Êtes-vous sûr de vouloir supprimer ce quiz ? Cette action est irréversible.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Annuler", style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  showloading(context);
                                  await FirebaseFirestore.instance
                                      .collection("quizzes")
                                      .doc(widget.model.quizzID)
                                      .delete()
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("SUPPRIMER", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "Supprimer",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
