import 'package:flutter/material.dart';

//Ceci est notre page montrant notre Politique de Confidentialité chez ShakeUp
class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text(
          'Politique de confidentialité',
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100], // Couleur de fond verte pour l'AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacement autour du contenu principal
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Politique de Confidentialité',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Dernière mise à jour : 27 Janvier 2024',
                style: bodyStyle(),
              ),
              const SizedBox(height: 16),
              Text(
                'Bienvenue sur ShakeUp, une application conçue pour sensibiliser et informer les enfants et les jeunes sur les tremblements de terre. Votre vie privée est une priorité pour nous. Cette politique de confidentialité explique comment nous collectons, utilisons, protégeons et partageons vos informations lorsque vous utilisez notre application.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '1. Informations que nous collectons',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous nous engageons à limiter la collecte d’informations personnelles. Voici les types de données que nous pouvons recueillir :',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Informations non personnelles : Données anonymes telles que l’âge, le pays ou la langue, utilisées pour améliorer l’expérience utilisateur.',
                style: bodyStyle(),
              ),
              Text(
                '- Données de jeu : Progression dans le jeu, scores et préférences, uniquement pour personnaliser l’expérience.',
                style: bodyStyle(),
              ),
              Text(
                '- Données techniques : Informations sur l’appareil (modèle, système d’exploitation) pour assurer la compatibilité et la performance.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous ne collectons aucune information personnelle identifiable (comme le nom, l’adresse ou l’e-mail) sans le consentement explicite des parents ou tuteurs légaux.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '2. Utilisation des informations',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Les informations collectées sont utilisées pour :',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Fournir une expérience de jeu personnalisée et éducative.',
                style: bodyStyle(),
              ),
              Text(
                '- Améliorer les fonctionnalités de l’application.',
                style: bodyStyle(),
              ),
              Text(
                '- Analyser l’utilisation de l’application pour optimiser son contenu.',
                style: bodyStyle(),
              ),
              Text(
                '- Respecter les obligations légales.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '3. Protection des données',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous mettons en œuvre des mesures de sécurité techniques et organisationnelles pour protéger vos données contre tout accès non autorisé, modification ou destruction.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '4. Partage des informations',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous ne partageons pas vos informations avec des tiers, sauf dans les cas suivants :',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Avec votre consentement explicite.',
                style: bodyStyle(),
              ),
              Text(
                '- Pour répondre à une obligation légale ou réglementaire.',
                style: bodyStyle(),
              ),
              Text(
                '- Pour protéger les droits, la sécurité ou la propriété de l’application.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '5. Consentement des parents',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Conformément aux réglementations comme le COPPA (Children’s Online Privacy Protection Act) et le RGPD (Règlement Général sur la Protection des Données), nous obtenons le consentement vérifiable des parents ou tuteurs légaux avant de collecter des informations personnelles auprès des enfants de moins de 13 ans.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '6. Vos droits',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Vous avez le droit de :',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Accéder aux informations que nous détenons sur vous.',
                style: bodyStyle(),
              ),
              Text(
                '- Demander la correction ou la suppression de vos données.',
                style: bodyStyle(),
              ),
              Text(
                '- Retirer votre consentement à tout moment.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Pour exercer ces droits, contactez-nous à l’adresse suivante : contact@shakeup.com.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '7. Modifications de la politique de confidentialité',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous pouvons mettre à jour cette politique de temps à autre. Toute modification sera publiée sur cette page avec une date de mise à jour révisée.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '8. Nous contacter',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Si vous avez des questions concernant cette politique de confidentialité ou nos pratiques, veuillez nous contacter à :',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'ShakeUp\ncontact@shakeup.com',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                'Merci de faire confiance à ShakeUp pour sensibiliser les jeunes aux tremblements de terre tout en protégeant leur vie privée.',
                style: bodyStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour styliser les titres
  TextStyle titleStyle() {
    return const TextStyle(
      fontFamily: 'Arima',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  // Fonction pour styliser le corps du texte
  TextStyle bodyStyle() {
    return const TextStyle(
      fontFamily: 'Arima',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }
}