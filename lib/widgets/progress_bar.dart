import 'package:flutter/material.dart';

//Cette fonction affiche le cercle qui charge avant d'afficher certains widgets asynchrones
circularProgress() {
  return Container(
    alignment: Alignment.center,
    width: 20,
    height: 20,
    // padding: const EdgeInsets.only(top: 15),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.blueGrey
      ),
    ),
  );
}
linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 15),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
          Colors.yellow[500]
      ),
    ),
  );
}