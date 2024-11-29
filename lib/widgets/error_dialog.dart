import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ErrorDialog extends StatelessWidget {

  final String? message;
  ErrorDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!, style: TextStyle()),
      actions: [
        ElevatedButton(
          child: Center(
            child: Text("OK", style: TextStyle(color: Colors.white),),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(55, 136, 162, 1.0)
          ),
          onPressed: () {
            Navigator.pop(context);
          },)
      ],
    );
  }
}