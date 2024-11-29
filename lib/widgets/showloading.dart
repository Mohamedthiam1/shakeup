import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showloading(context) {
  return showDialog(
      // routeSettings: RouteSettings(),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Container(
        child: Center(
          child: LoadingAnimationWidget.twistingDots(
              leftDotColor: Colors.blue,
              rightDotColor: Colors.lightBlueAccent,
              size: 100
          ),
        ),
      ));
}