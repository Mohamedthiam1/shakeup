import 'package:flutter/material.dart';

//page d'informations "Avant un Séisme"
class AvantPage extends StatelessWidget {
  const AvantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: const Text("Avant un Séisme",
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
        padding: EdgeInsets.all(16.0), // Marges autour du contenu pour un espacement uniforme
        child: SingleChildScrollView(
          // Permet le défilement si le contenu dépasse la hauteur de l'écran
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Contenu aligné à gauche
            children: [
              // Section 1: Comprendre les tremblements de terre
              _buildSection(
                '1. Qu’est-ce qu’un tremblement de terre ? 🌍',
                'Un tremblement de terre, c’est quand la Terre bouge ! Cela arrive '
                    'parce que des plaques sous le sol glissent. Pas de panique, on peut apprendre à se protéger !',
                Icons.emoji_nature,
                'La Terre est vivante et parfois elle danse ! 🌍✨',
              ),

              // Section 2: Construire un kit d'urgence
              _buildSection(
                  '2. Fabrique ton kit d’urgence 🎒',
                  'Un sac magique pour être prêt en cas d’urgence ! Ajoute ces objets :',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.flashlight_on, 'text': 'Une lampe de poche pour voir dans le noir.'},
                    {'icon': Icons.medical_services, 'text': 'Une trousse de secours pour soigner les petits bobos.'},
                    {'icon': Icons.water_drop, 'text': 'De l’eau pour rester hydraté.'},
                    {'icon': Icons.cookie, 'text': 'Des snacks pour avoir de l’énergie.'},
                    {'icon': Icons.bed, 'text': 'Une couverture pour rester au chaud.'},
                    {'icon': Icons.volume_up, 'text': 'Un sifflet pour appeler à l’aide.'},
                  ]
              ),

              // Section 3: Les gestes qui sauvent
              _buildSection(
                  '3. Les gestes qui sauvent 🚨',
                  'Apprends ces 3 gestes importants pour te protéger :',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.pan_tool, 'text': '1. Baisse-toi pour éviter de tomber.'},
                    {'icon': Icons.shield, 'text': '2. Cache-toi sous une table solide.'},
                    {'icon': Icons.handshake, 'text': '3. Accroche-toi jusqu’à ce que ça s’arrête.'},
                  ]
              ),

              // Section 4: Préparer sa maison
              _buildSection(
                  '4. Rends ta maison plus sûre 🏡',
                  'Voici comment sécuriser ta maison :',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.lock, 'text': 'Demande à un adulte de fixer les meubles lourds au mur.'},
                    {'icon': Icons.cleaning_services, 'text': 'Range les objets fragiles et les jouets sous les étagères.'},
                    {'icon': Icons.search, 'text': 'Repère les coins sûrs où tu peux te cacher (comme sous une table).'},
                    {'icon': Icons.delete, 'text': 'Ramasse les jouets qui traînent pour ne pas que quelqu’un tombe.'},
                    {'icon': Icons.check_circle, 'text': 'Vérifie que rien ne bloque la sortie d’urgence.'},
                    {'icon': Icons.add, 'text': 'Étiquette ton kit d’urgence pour savoir où il est en cas de besoin.'},
                  ]
              ),

              // Section 5: Numéros d'urgence
              _buildSection(
                  '5. Les numéros importants à retenir 📞',
                  'Garde ces numéros à portée de main :',
                  null,
                  null,
                  listItems: [
                    {'icon': Icons.fire_extinguisher, 'text': 'Pompiers : 18'},
                    {'icon': Icons.local_police, 'text': 'Police : 17'},
                    {'icon': Icons.health_and_safety, 'text': 'Urgences médicales : 15'},
                    {'icon': Icons.phone, 'text': 'Ajoute le numéro de ta famille.'},
                  ]
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Retour à la page précédente
                  },
                  child: const Text('Retour à l\'Accueil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(
                      fontFamily: 'Arima',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      String title,
      String content,
      IconData? icon,
      String? iconText, {
        List<Map<String, dynamic>>? listItems,
      }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          if (icon != null && iconText != null) ...[
            SizedBox(height: 10),
            _iconWithText(icon, iconText),
          ],
          if (listItems != null) ...[
            SizedBox(height: 10),
            _listItemsWithIcons(listItems),
          ],
        ],
      ),
    );
  }

  Widget _iconWithText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 32, color: Colors.green),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _listItemsWithIcons(List<Map<String, dynamic>> items) {
    return Column(
      children: items.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item['icon'], color: Colors.blueAccent, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                item['text'],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
