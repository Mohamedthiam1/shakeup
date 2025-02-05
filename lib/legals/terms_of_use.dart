import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {

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
          'Conditions d\'utilisation',
          style: TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conditions Générales d\'Utilisation (CGU)',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Dernière mise à jour : 27 Janvier 2024',
                style: bodyStyle(),
              ),
              const SizedBox(height: 16),
              Text(
                'Bienvenue sur ShakeUp, une application éducative conçue pour sensibiliser et informer les enfants et les jeunes sur les tremblements de terre. En utilisant cette application, vous acceptez les conditions générales d\'utilisation décrites ci-dessous.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '1. Acceptation des conditions',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'En téléchargeant, accédant ou utilisant ShakeUp, vous acceptez d\'être lié par ces Conditions Générales d\'Utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser l\'application.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '2. Utilisation de l\'application',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Âge minimum : L\'application est destinée aux enfants et aux jeunes, mais son utilisation par des enfants de moins de 13 ans nécessite le consentement préalable d\'un parent ou tuteur légal.',
                style: bodyStyle(),
              ),
              Text(
                '- Objectif éducatif : L\'application est conçue pour informer et sensibiliser sur les tremblements de terre. Elle ne remplace pas les conseils de professionnels ou les mesures de sécurité officielles.',
                style: bodyStyle(),
              ),
              Text(
                '- Utilisation responsable : Vous vous engagez à utiliser l\'application de manière légale et à ne pas perturber son fonctionnement ou son accès pour les autres utilisateurs.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '3. Comptes utilisateurs',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Création de compte : Certaines fonctionnalités peuvent nécessiter la création d\'un compte. Vous devez fournir des informations exactes et à jour.',
                style: bodyStyle(),
              ),
              Text(
                '- Sécurité du compte : Vous êtes responsable de la confidentialité de vos identifiants et de toutes les activités réalisées sous votre compte.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '4. Propriété intellectuelle',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Droits d\'auteur : Tout le contenu de l\'application (textes, images, sons, vidéos) est protégé par des droits d\'auteur et appartient à ShakeUp ou à ses partenaires.',
                style: bodyStyle(),
              ),
              Text(
                '- Utilisation limitée : Vous n\'êtes pas autorisé à copier, modifier, distribuer ou exploiter le contenu de l\'application sans autorisation écrite préalable.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '5. Limitation de responsabilité',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                '- Utilisation à vos risques : L\'application est fournie "telle quelle". Nous ne garantissons pas qu\'elle sera exempte d\'erreurs ou de bugs.',
                style: bodyStyle(),
              ),
              Text(
                '- Dommages indirects : Nous ne serons pas responsables des dommages indirects (pertes de données, interruptions de service, etc.) résultant de l\'utilisation de l\'application.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '6. Modifications des CGU',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous nous réservons le droit de modifier ces Conditions Générales d\'Utilisation à tout moment. Les modifications seront publiées sur cette page avec une date de mise à jour révisée. Votre utilisation continue de l\'application après ces modifications constitue votre acceptation des nouvelles conditions.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '7. Résiliation',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous nous réservons le droit de résilier ou de suspendre votre accès à l\'application en cas de non-respect de ces CGU ou de comportement inapproprié.',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '8. Loi applicable',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Ces Conditions Générales d\'Utilisation sont régies par les lois de [Pays/Région]. Tout litige relatif à l\'utilisation de l\'application sera soumis à la juridiction compétente de [Ville/Pays].',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                '9. Nous contacter',
                style: titleStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'Si vous avez des questions concernant ces Conditions Générales d\'Utilisation, veuillez nous contacter à :',
                style: bodyStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'ShakeUp\ncontact@shakeup.com',
                style: bodyStyle(),
              ),
              const SizedBox(height: 24),
              Text(
                'Merci d\'utiliser ShakeUp pour sensibiliser les jeunes aux tremblements de terre tout en respectant ces conditions.',
                style: bodyStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }

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