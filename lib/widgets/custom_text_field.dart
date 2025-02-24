import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../global/global.dart';

//Nous avons créer un CustomTextField afin d'uniformiser tous nos TextFields ou la plupart et pour un accès plus facile et avec moins de code
class CustomTextField extends StatelessWidget {

  final TextEditingController? controller;
  final Widget? data;
  final String? hintText;
  bool? isObscure = true;
  bool? enabled = true;
  Color? backgroundColor;
  Widget? suffixIcon;
  int? maxLines;
  int? maxLength;
  TextStyle? counterStyle;
  String? counterText;
  FocusNode? focusNode;
  TextCapitalization textCapitalization = TextCapitalization.none;
  Function(String)? onChanged;
  Function(String)? onSubmitted;
  Function()? onTap;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  double marginleft = 30;
  double marginright = 30;
  final List<TextInputFormatter>? inputFormatters;
  String? autofillHints;

  CustomTextField({super.key,
    this.controller,
    this.data,
    this.hintText,
    this.isObscure,
    this.enabled,
    this.suffixIcon,
    this.backgroundColor,
    this.onChanged,
    this.maxLines,
    this.maxLength,
    this.counterStyle,
    this.counterText,
    required this.textCapitalization,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.onTap,
    this.inputFormatters,
    required this.marginleft,
    required this.marginright,
    this.focusNode,
    this.autofillHints
  });



  @override
  Widget build(BuildContext context) {
    return
      Container(
      // decoration: BoxDecoration(
      //     color: backgroundColor,
      //     borderRadius: const BorderRadius.all(Radius.circular(25))
      // ),
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(left: marginleft, right: marginright),
      child: CupertinoTextField(
        autofillHints: [autofillHints ?? ""],
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        maxLines: maxLines,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color.fromRGBO(228, 228, 228, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        placeholderStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
        inputFormatters: inputFormatters,
        suffix: suffixIcon,
        onTap: onTap,
        maxLength: maxLength,
        textInputAction: textInputAction,
        enabled: enabled!,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        obscureText: isObscure!,
        textCapitalization: textCapitalization,
        cursorColor: Theme.of(context).primaryColor,
        prefix: data,
        placeholder: hintText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}