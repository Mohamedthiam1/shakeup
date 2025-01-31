import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cap/models/badge.dart';
import '../models/trophy.dart';

class TropheeScreen extends StatefulWidget {
  const TropheeScreen({super.key});

  @override
  State<TropheeScreen> createState() => _TropheeScreenState();
}

class _TropheeScreenState extends State<TropheeScreen> {
  late List<BadgeModel> badges;
  late List<Trophy> trophies;
  bool hasReceivedFastAnswerTrophy = false;

  @override
  void initState() {
    super.initState();
    badges = [
      BadgeModel(
        title: 'Expert en sécurité',
        description: 'Répond correctement à toutes les questions sur les gestes à adopter durant un séisme.',
        icon: Icons.shield,  // Cadenas par défaut
        iconColor: Colors.blue,  // Couleur grise pour badge verrouillé
        criteria: 'Répondre à 10 questions.',
        unlocked: false, // Badge verrouillé au départ
      ),
      BadgeModel(
        title: 'Chercheur débutant',
        description: 'Consulte une fiche éducative.',
        icon: Icons.search,  // Cadenas par défaut
        iconColor: Colors.blue,  // Couleur grise pour badge verrouillé
        criteria: 'Consulte une fiche éducative.',
        unlocked: false, // Badge verrouillé au départ
      ),
      BadgeModel(
        title: 'Collectionneur',
        description: 'Collectionne 5 trophées.',
        icon: Icons.public,
        iconColor: Colors.blue,  // Couleur grise pour badge verrouillé
        criteria: 'Obtenir 5 trophées.',
        unlocked: false, // Badge verrouillé au départ
      ),
      BadgeModel(
        title: 'Survivant',
        description: 'A obtenu un score de 100 % dans un quiz sur les mesures de sécurité.',
        icon: Icons.check_circle,
        iconColor: Colors.green,
        criteria: 'Répondre correctement à toutes les questions d\'un quiz de sécurité.',
        unlocked: false,
      ),
      BadgeModel(
        title: 'Historien des Tremblements',
        description: 'A étudié et complété des rapports sur 10 tremblements de terre historiques.',
        icon: Icons.history,
        iconColor: Colors.blue,
        criteria: 'Terminer des articles éducatifs sur 10 tremblements de terre.',
        unlocked: false,
      ),
      BadgeModel(
        title: 'Champion de la Préparation',
        description: 'A complété un quiz sur la préparation avant un séisme.',
        icon: Icons.check,
        iconColor: Colors.orange,
        criteria: 'Répondre à un quiz de préparation avec un score de 80 % ou plus.',
        unlocked: false,
      ),
      BadgeModel(
        title: 'Ambassadeur de la Sécurité',
        description: 'A partagé des conseils de sécurité avec 5 amis.',
        icon: Icons.share,
        iconColor: Colors.purple,
        criteria: 'Utiliser la fonctionnalité de partage de l\'application.',
        unlocked: false,
      ),
      BadgeModel(
        title: 'Meneur de Projet',
        description: 'A dirigé une discussion sur la sécurité en cas de tremblement de terre.',
        icon: Icons.group,
        iconColor: Colors.red,
        criteria: 'Participer à une discussion de groupe ou un forum dans l\'application.',
        unlocked: false,
      ),
    ];

    trophies = [
      Trophy(
        title: 'Récolteur de points',
        description: 'Obtenir ses 15 premiers points',
        unlocked: false,
        points: 20,
      ),
      Trophy(
        title: 'Expert en Sécurité',
        description: 'Débloqué après avoir correctement répondu à 10 questions sur les gestes à adopter durant un séisme.',
        unlocked: false,
        points: 50,
      ),
      Trophy(
        title: 'Répondant Rapide',
        description: 'Débloqué en répondant à un quiz en moins de 15 secondes.',
        unlocked: false,
        points: 30,
      ),
      Trophy(
        title: 'Voyageur du Temps',
        description: 'Débloqué en étudiant 5 tremblements de terre historiques.',
        unlocked: false,
        points: 40,
      ),
      Trophy(
        title: 'Stratège Sismique',
        description: 'Débloqué en atteignant un score parfait dans un quiz sur les stratégies de survie.',
        unlocked: false,
        points: 60,
      ),
      Trophy(
        title: 'Enquêteur des Tremblements',
        description: 'Débloqué en complétant un rapport sur un tremblement de terre spécifique.',
        unlocked: false,
        points: 70,
      ),
    ];
    _checkEducationalFileOpened();
    _checkFastAnswerTrophy();
    _checkTrophies();
  }

  Future<void> _checkEducationalFileOpened() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasOpened = prefs.getBool('opened_educational_file') ?? false;

    if (hasOpened) {
      setState(() {
        badges[1] = BadgeModel(
          title: 'Chercheur débutant',
          description: 'Débloqué après avoir consulté une fiche éducative.',
          icon: Icons.search,  // Change l'icône en étoile pour un badge débloqué
          iconColor: Colors.blue,  // Couleur bleue pour badge débloqué
          criteria: 'Débloqué ✅',
          unlocked: true, // Badge débloqué
        );
      });
    }
  }

  // Vérification si le trophée "Répondant Rapide" est débloqué
  Future<void> _checkFastAnswerTrophy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasReceived = prefs.getBool('fast_answer_trophy') ?? false;
    if (hasReceived) {
      setState(() {
        // Mise à jour du trophée "Répondant Rapide"
        trophies[2] = Trophy(
          title: 'Répondant Rapide',
          description: 'Débloqué en répondant à un quiz en moins de 15 secondes.',
          unlocked: true, // Le trophée est maintenant débloqué
          points: 30,
        );
      });
    }
  }

  Future<void> _checkTrophies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasUnlockedTrophy = prefs.getBool('unlocked_recolteur_points') ?? false;

    // Vérifier si le trophée "Récolteur de points" est débloqué
    if (hasUnlockedTrophy) {
      setState(() {
        trophies[0] = Trophy(
          title: 'Récolteur de points',
          description: 'Débloqué après avoir atteint 15 points.',
          unlocked: true,
          points: 20,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Trophées et Badges",
          style: TextStyle(fontFamily: 'Arima', fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Badges'),
          ...badges.map((badge) => _buildBadgeTile(badge)),
          _buildSectionHeader('Trophées'),
          ...trophies.map((trophy) => _buildTrophyTile(trophy)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontFamily: 'Arima', fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeTile(BadgeModel badge) {
    return ListTile(
      leading: Icon(
        badge.unlocked ? badge.icon : Icons.lock,  // Si le badge est débloqué, affiche l'icône appropriée sinon un cadenas.
        color: badge.unlocked ? badge.iconColor : Colors.grey, // Change la couleur selon le statut du badge
        size: 40,
      ),
      title: Text(
        badge.title,
        style: const TextStyle(fontFamily: 'Arima', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      subtitle: Text(badge.description),
      trailing: badge.unlocked // Affiche "Débloqué ✅" si le badge est débloqué
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.lock, color: Colors.grey),
    );
  }

  Widget _buildTrophyTile(Trophy trophy) {
    return ListTile(
      leading: Icon(
        trophy.unlocked ? Icons.emoji_events : Icons.lock, // Si le trophée est débloqué, affiche une icône de trophée, sinon un cadenas.
        color: trophy.unlocked ? Colors.amber : Colors.grey, // Couleur d'icône en fonction du déblocage.
        size: 40,
      ),
      title: Text(
        trophy.title,
        style: const TextStyle(
          fontFamily: 'Arima',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      subtitle: Text(trophy.description),
      trailing: trophy.unlocked
          ? Text(
        '${trophy.points} pts',
        style: const TextStyle(
          fontFamily: 'Arima',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black, // Couleur des points si le trophée est débloqué.
        ),
      )
          : const Icon(Icons.lock, color: Colors.grey), // Affiche l'icône de cadenas à la place des points si non débloqué.
    );
  }
}
