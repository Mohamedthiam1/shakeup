import 'package:flutter/material.dart';

import 'event.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Dynamix")
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("bienvenue",
                      style: TextStyle(
                          fontSize: 24
                      )
                  ),
                  const Text("Salon",
                      style: TextStyle(
                          fontSize: 24
                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                        backgroundColor: WidgetStatePropertyAll(Colors.green)
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => Event()
                          )
                      );
                    },
                    child: Text("afficher planning"),
                  )
                ]
            )
        )
    );
  }
}
