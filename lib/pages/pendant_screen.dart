import 'package:flutter/material.dart';



class PendantScreen extends StatefulWidget {
  const PendantScreen({super.key});

  @override
  State<PendantScreen> createState() => _PendantScreenState();
}

class _PendantScreenState extends State<PendantScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendant un séisme'),
        backgroundColor: Colors.green, // Bannière verte
        centerTitle: true, // Pour centrer le titre
      ),
      body: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meuble',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n'
                    '- Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n'
                    '- Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n'
                    '- Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n'
                    '- Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n'
                    '- Proin eget tortor risus. Nulla porttitor accumsan tincidunt.\n'
                    '- Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem.\n'
                    '- Donec sollicitudin molestie malesuada.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
