import 'package:flutter/material.dart';
class Event extends StatelessWidget {
  const Event({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("planning"),
      ),
      body: const Center(
        child: Text("bientot dispo"),
      ),
    );
  }
}