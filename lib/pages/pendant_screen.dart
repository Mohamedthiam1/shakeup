import 'package:cap/models/badge.dart';
import 'package:flutter/material.dart';

import '../models/trophy.dart';

class PendantScreen extends StatefulWidget {
  const PendantScreen({super.key});

  @override
  State<PendantScreen> createState() => _PendantScreenState();
}

class _PendantScreenState extends State<PendantScreen> {

  final List<BadgeModel> badges = [
    BadgeModel(
      title: 'Expert en sécurité',
      description:
      'Répond correctement à toutes les questions sur les gestes à adopter durant un séisme.',
      icon: Icons.shield,
      iconColor: Colors.green,
      criteria: 'Répondre à 10 questions.',
    ),
    BadgeModel(
      title: 'Chercheur débutant',
      description: 'Finir le mode débutant.',
      icon: Icons.child_care,
      iconColor: Colors.blue,
      criteria: 'Compléter le mode débutant.',
    ),
    BadgeModel(
      title: 'Collectionneur',
      description: 'Collectionne 5 trophées.',
      icon: Icons.public,
      iconColor: Colors.blue,
      criteria: 'Obtenir 5 trophées.',
    ),
    BadgeModel(
      title: 'Survivant',
      description:
      'A obtenu un score de 100 % dans un quiz sur les mesures de sécurité.',
      icon: Icons.check_circle,
      iconColor: Colors.green,
      criteria:
      'Répondre correctement à toutes les questions d\'un quiz de sécurité.',
    ),
    BadgeModel(
      title: 'Historien des Tremblements',
      description:
      'A étudié et complété des rapports sur 10 tremblements de terre historiques.',
      icon: Icons.history,
      iconColor: Colors.blue,
      criteria: 'Terminer des articles éducatifs sur 10 tremblements de terre.',
    ),
    BadgeModel(
      title: 'Champion de la Préparation',
      description: 'A complété un quiz sur la préparation avant un séisme.',
      icon: Icons.check,
      iconColor: Colors.orange,
      criteria:
      'Répondre à un quiz de préparation avec un score de 80 % ou plus.',
    ),
    BadgeModel(
      title: 'Ambassadeur de la Sécurité',
      description: 'A partagé des conseils de sécurité avec 5 amis.',
      icon: Icons.share,
      iconColor: Colors.purple,
      criteria: 'Utiliser la fonctionnalité de partage de l\'application.',
    ),
    BadgeModel(
      title: 'Meneur de Projet',
      description:
      'A dirigé une discussion sur la sécurité en cas de tremblement de terre.',
      icon: Icons.group,
      iconColor: Colors.red,
      criteria:
      'Participer à une discussion de groupe ou un forum dans l\'application.',
    ),
  ];

  final List<Trophy> trophies = [
    Trophy(
      title: 'Expert en Sécurité',
      description:
      'Débloqué après avoir correctement répondu à 10 questions sur les gestes à adopter durant un séisme.',
      unlocked: true,
      points: 50,
    ),
    Trophy(
      title: 'Répondant Rapide',
      description: 'Débloqué en répondant à un quiz en moins de 2 minutes.',
      unlocked: false,
      points: 30,
    ),
    Trophy(
      title: 'Voyageur du Temps',
      description: 'Débloqué en étudiant 5 tremblements de terre historiques.',
      unlocked: true,
      points: 40,
    ),
    Trophy(
      title: 'Stratège Sismique',
      description:
      'Débloqué en atteignant un score parfait dans un quiz sur les stratégies de survie.',
      unlocked: false,
      points: 60,
    ),
    Trophy(
      title: 'Enquêteur des Tremblements',
      description:
      'Débloqué en complétant un rapport sur un tremblement de terre spécifique.',
      unlocked: true,
      points: 70,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trophées et Badges'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Badges'),
          ...badges.map((badge) => _buildBadgeTile(badge)).toList(),
          _buildSectionHeader('Trophées'),
          ...trophies.map((trophy) => _buildTrophyTile(trophy)).toList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeTile(BadgeModel badge) {
    return ListTile(
      leading: Icon(
        badge.icon,
        color: badge.iconColor,
        size: 40,
      ),
      title: Text(
        badge.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(badge.description),
    );
  }

  Widget _buildTrophyTile(Trophy trophy) {
    return ListTile(
      leading: Icon(
        trophy.unlocked ? Icons.emoji_events : Icons.lock,
        color: trophy.unlocked ? Colors.amber : Colors.grey,
        size: 40,
      ),
      title: Text(
        trophy.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: trophy.unlocked ? Colors.black : Colors.grey,
        ),
      ),
      subtitle: Text(
        trophy.description,
        style: TextStyle(
          color: trophy.unlocked ? Colors.black54 : Colors.grey,
        ),
      ),
      trailing: Text(
        '${trophy.points} pts',
        style: TextStyle(color: trophy.unlocked ? Colors.black : Colors.grey),
      ),
    );
  }
}
