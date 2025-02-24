import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ErrorDialog extends StatelessWidget {

  //Ceci est une simple boite de dialogue par défaut, selon le message à afficher, qui affiche des messages en cas d'erreur
  final String? message;
  ErrorDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!, style: const TextStyle()),
      actions: [
        ElevatedButton(
          child: const Center(
            child: Text("OK", style: TextStyle(color: Colors.white),),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(55, 136, 162, 1.0)
          ),
          onPressed: () {
            Navigator.pop(context);
          },)
      ],
    );
  }
}