import 'package:cap/admin/add_quizz_screen.dart';
import 'package:cap/design_widgets/quizz_design_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/quizz.dart';
import '../widgets/progress_bar.dart';

class ManageQuizzScreen extends StatefulWidget {
  const ManageQuizzScreen({super.key});

  @override
  State<ManageQuizzScreen> createState() => _ManageQuizzScreenState();
}

class _ManageQuizzScreenState extends State<ManageQuizzScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    //Dès que la page est quittée on ramène l'orientation en mode Paysage comme au début
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
        .then((_) {});
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gérer Quizz"),
      ),
      //Ce bouton flottant nous permettra de naviguer vers la page d'ajout de quizz au besoin
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey.withOpacity(0.5),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AddQuizzScreen()));
          }, label: const Icon(Icons.add_rounded, color: Colors.black, size: 25,)),
      body: CustomScrollView(
        slivers: [
          //Ici nous utilisons un Streambuilder afin d'écouter les changements en live depuis la base de données
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("quizzes").orderBy("quizzID", descending: true)
                  .snapshots(),//Nous recuperons tous les quizz
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                  child: Center(
                    child: circularProgress(),//Chargement en attendant la réception des données
                  ),
                )
                    : SliverStaggeredGrid.countBuilder(// Ce widget nous permet d'afficher les questions d'une bonne façon et avec un widget de type Sliver comme nous sommes dans un CustomScrollView
                  crossAxisCount: 1,
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Quizz model = Quizz.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return QuizzDesignWidget(model: model, context: context);
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              }
          ),
        ],
      ),
    );
  }
}
