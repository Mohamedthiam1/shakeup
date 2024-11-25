class Trophy {
  final String title;
  final String description;
  final bool unlocked;
  final int points; // Points attribués

  Trophy({
    required this.title,
    required this.description,
    required this.unlocked,
    required this.points, // Nouveau champ
  });
}
