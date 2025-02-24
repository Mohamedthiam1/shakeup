import 'package:flutter/material.dart';

// Ce model représente les objets de type Badge
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
    required this.criteria,
    this.unlocked = false,
  });
}