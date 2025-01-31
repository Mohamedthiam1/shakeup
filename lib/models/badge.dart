import 'package:flutter/material.dart';

class BadgeModel {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String criteria; // Critères de déblocage
  bool unlocked;

  BadgeModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.criteria, // Nouveau champ
    this.unlocked = false,
  });
}