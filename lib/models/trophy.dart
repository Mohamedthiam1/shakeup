class Trophy {
  final String title;
  final String description;
  bool unlocked;
  int points; // Points attribués

  Trophy({
    required this.title,
    required this.description,
    required this.unlocked,
    this.points=0, // Nouveau champ
  });
}

