import 'package:cap/admin/add_quizz_screen.dart';
import 'package:cap/admin/manage_quizz_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';
import '../global/global.dart';
import '../widgets/error_dialog.dart';
import '../widgets/showloading.dart';

// Page des paramètres de l'appli

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'Français'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Charger la langue au démarrage
  }

  // Charger la langue depuis SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language');
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de retour
          onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },
        ),
        title: Text(selectedLanguage == 'Français' ? 'Réglages' : 'Settings',
          style: const TextStyle(
            fontFamily: 'Arima',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green[100], // Couleur de fond verte pour l'AppBar
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async {
            logoutSafely(context);
          }, icon: const Icon(Icons.logout_rounded, color: Colors.redAccent,))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0), // Marges autour du contenu principal
        child: SizedBox(
          width: width, // Largeur du contenu alignée à l'écran
          child: SingleChildScrollView(
            // Permet le défilement si le contenu dépasse la taille de l'écran
            child: Container(
              alignment: Alignment.center, // Centre tout le contenu horizontalement
              margin: EdgeInsets.symmetric(horizontal: width * 0.03), // Marges latérales dynamiques

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centre tous les enfants de manière horizontale
                children: [

                  // Section pour la connexion via les réseaux sociaux
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFC7E4BF), // Fond vert clair
                      borderRadius: BorderRadius.circular(15), // Coins arrondis
                    ),
                    padding: const EdgeInsets.all(10), // Espacement interne
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              selectedLanguage == 'Français' ? 'Connexion' : 'Login',
                              style: const TextStyle(
                                fontFamily: 'Arima',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            if (sharedPreferences!.getString("fullname") != null)
                              Text(
                                selectedLanguage == 'Français'
                                    ? 'Bienvenu ${sharedPreferences!.getString("fullname")},'
                                    : 'Welcome ${sharedPreferences!.getString("fullname")},',
                                style: const TextStyle(
                                  fontFamily: 'Arima',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10), // Espacement
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribution égale des boutons
                          children: [
                            SocialButton('Google', 'assets/images/icons8-google-48.png'),
                            SocialButton('Apple', 'assets/images/icons8-apple-50.png'),
                            SocialButton('Facebook', 'assets/images/icons8-facebook-48.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  if(sharedPreferences!.getString("uid") != null)
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          setPortrait = true;
                        });
                        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
                            .then((_) {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ManageQuizzScreen()));
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddQuizzScreen()));
                        });
                      }, style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC7E4BF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))
                  ), child: Row(
                    children: [
                      Text(selectedLanguage == 'Français' ? 'Gérer Quizz' : 'Manage Quizzes', style: const TextStyle(color: Colors.black),),
                    ],
                  )),

                  // Options de réglages avec des interrupteurs
                  SettingToggle(title: selectedLanguage == 'Français' ? 'Son' : 'Sound'),
                  SettingToggle(title: selectedLanguage == 'Français' ? 'Vibrations' : 'Vibrations'),
                  SettingToggle(title: selectedLanguage == 'Français' ? 'Musique' : 'Music'),
                  SettingToggle(title: selectedLanguage == 'Français' ? 'Notifications' : 'Notifications'),

                  // Menu déroulant pour le choix de la langue
                  const LanguageDropdown(),

                  // Liens vers d'autres pages
                  SettingLink(title: selectedLanguage == 'Français' ? 'Politique de confidentialité' : 'Privacy Policy', routeName: '/privacy'),
                  SettingLink(title: selectedLanguage == 'Français' ? 'Conditions d\'utilisation' : 'Terms of Use', routeName: '/terms'),
                  SettingLink(title: selectedLanguage == 'Français' ? 'Support' : 'Support'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void logoutSafely(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // showDragHandle: true,
      builder: (BuildContext context) {
        final double width = MediaQuery.of(context).size.width;
        return Container(
          width: width,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStater) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,

                        child: RichText(
                          text: const TextSpan(
                            text: 'Voulez-vous vous ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "déconnecter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: " ?",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: width * 1.7 / 5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(176, 191, 192, 1.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                onPressed: () async {
                                  HapticFeedback.selectionClick();
                                  Navigator.pop(context);
                                },
                                child: const Text("RETOURNER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Container(
                              width: width * 0.5 / 5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                onPressed: () async {
                                  HapticFeedback.selectionClick();
                                  showloading(context);
                                  FirebaseFirestore.instance.collection("users").doc(sharedPreferences!.getString("uid")).update({
                                    "token": ""
                                  }).whenComplete(() async {
                                    await FirebaseAuth.instance.signOut().whenComplete(() {
                                      sharedPreferences!.clear();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => const SettingsPage()));
                                    });
                                  });
                                },
                                child: const Icon(Icons.logout_rounded, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ).then((value) {
      if (value != null && value == true) {
        // Proceed with the action
        // print('Action confirmed');
      } else {
        // Cancelled
        // print('Action cancelled');
      }
    });
  }

  Widget SocialButton(String label, String iconPath) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min, // Ajuste la taille pour correspondre au contenu
          children: [
            Image.asset(
              iconPath, // Affiche l'icône
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 2), // Espacement entre l'icône et le texte
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Arima',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: sharedPreferences!.getString("uid") != null ? null : () {
            if(label == 'Google') {
              print("Google signIn started");
              GoogleSignIn(clientId: DefaultFirebaseOptions.currentPlatform.iosClientId).signIn().then((account) async {
                print(account!.email);
                print(account.photoUrl);
                print(account.displayName);
                print(account.id);
                Fluttertoast.showToast(msg: "Redirecting...", timeInSecForIosWeb: 4);
                bool userAlreadyExists = await doesUserExistWithEmail(account.email);
                if (userAlreadyExists) {
                  String hidden = await fetchHiddenThingGoogle();
                  formValidation(account.email, hidden, context, setState);
                }
                else {
                  String hidden = await fetchHiddenThingGoogle();
                  print(hidden);
                  showloading(context);
                  authenticateUserAndSignUp(account.email, hidden, account.displayName!, account.photoUrl!, "", context, setState);
                }
              }).catchError(( err) {
                print(err);
              });
              print("Google signIn ended");
            } else if(label == "Apple") {

            }
          }, // Action à définir lors de l'appui sur le bouton
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF36DD0C), // Couleur verte
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Coins arrondis
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Espacement interne
          ),
          child: Text(selectedLanguage == 'Français' ? 'Se connecter' : 'Login',
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

// Bouton pour les réseaux sociaux

  formValidation(String email, String hidden, BuildContext context, StateSetter setState) {
    print('Entered properly 1');
    if (email.isNotEmpty && hidden.isNotEmpty) {
      //Login
      // print(email);
      // print(hidden);
      loginNow(email, hidden, context, setState);
    } else {
      Fluttertoast.showToast(msg: "Veuillez entrer une adresse email et un mot de passe valides.", timeInSecForIosWeb: 3);
    }
  }

  Future readDataAndSetDataLocally(User currentUser, BuildContext context, StateSetter setState) async {
    print(currentUser.email! +" hello");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if(snapshot.exists)
      {
        print("Holaaaa");

        await sharedPreferences!.setString("status", snapshot.data()!["status"]);

        if(snapshot.data()!["status"] == "approved" || snapshot.data()!["status"] == "waiting") {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["email"] ?? "");
          print("Holaaaa --- ----- ");
          await sharedPreferences!.setString("fullname", snapshot.data()!["fullname"] ?? "");
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"] ?? "");
          await sharedPreferences!.setInt("joinDate", snapshot.data()!["joinDate"] ?? 0);
          print("Holaaaa  3333333333");

          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
            "numberofauthentications": (sharedPreferences!.getInt("numberofauthentications")!) + 1,
          });


          setState(() {
            sharedPreferences;
          });
          // Navigator.pop(context);
          Navigator.pop(context);
          // setState(() {
          //   sharedPreferences;
          // });
          print("8888888*${sharedPreferences!.getBool("isDoctor")!}");

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const SettingsPage(), fullscreenDialog: true));
        }

        else {
          firebaseAuth.signOut();
          // Navigator.pop(context);
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Votre comptre a été bloqué. Expliquez votre situation à: \n\nsupport@shakeup.com", timeInSecForIosWeb: 3);
        }
      }

      else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        // Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsPage(), fullscreenDialog: true));

        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(message: "Les informations ne correspondent pas. Réessayez.",);
            });
      }
    });
  }

  loginNow(String email, String hidden, BuildContext context, StateSetter setState) async {
    print('Entered login now');
    // print(email);
    // print(hidden);
    showloading(context);

    User? currentUser;
    try {
      UserCredential auth = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: hidden.trim(),
      );
      currentUser = auth.user;

      if (currentUser != null) {
        await readDataAndSetDataLocally(currentUser, context, setState);
      }
    } catch (error) {
      // Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsPage(), fullscreenDialog: true));
      print(error);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(message: "Une erreur est survenue. Veuillez réessayer ultérieurement!");
        },
      );
    }
  }

  Future saveDataToFirestore(User currentUser, String email, String fullname, String photoUrl, String userIdentifierApple, BuildContext context, StateSetter setState) async {

    String uid = currentUser.uid;

    FirebaseFirestore.instance.collection("users").doc(uid).set({
      "uid": uid,
      "email": email,
      "fullname": fullname,
      "photoUrl": photoUrl,
      "status": "approved",
      "joinDate": DateTime.now().millisecondsSinceEpoch,
      "token": "",
      "admin": false,
      "points": 0,
      "userIdentifierApple": userIdentifierApple,
      // "birthdate": DateTime(2000, 11, 9),
    }).whenComplete(() async{

      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences!.setString("uid", uid);
      await sharedPreferences!.setString("email", email);
      await sharedPreferences!.setString("status", "approved");
      await sharedPreferences!.setString("fullname", fullname);
      await sharedPreferences!.setString("photoUrl", photoUrl);
      await sharedPreferences!.setInt("points", 0);
      await sharedPreferences!.setInt("joinDate", DateTime.now().millisecondsSinceEpoch);
      setState(() {
        sharedPreferences;
      });

      FirebaseFirestore.instance.collection("emails").doc(email).set({
        'email': email
      }).then((value) {
        print("Thereeeee");
        //Send User to HomePage
        // Navigator.pop(context);
        // setState(() {
        //   sharedPreferences;
        // });
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const SettingsPage()));

      });
    });

  }

  void authenticateUserAndSignUp(String email, String hidden, String fullname, String photourl, String userIdentifierApple, BuildContext context, StateSetter setState) async{
    User? currentUser;
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: hidden.trim()).then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: "Error: ${error}");
          });
    });

    if(currentUser != null) {
      saveDataToFirestore(currentUser!, email, fullname, photourl, userIdentifierApple, context, setState);
    }
  }

}



Future<bool> doesUserExistWithEmail(String email) async {
  print('Check Email Verif!');
  try {
    final QuerySnapshot usersQuery = await FirebaseFirestore.instance
        .collection('emails')
        .where('email', isEqualTo: email)
        .get();

    return usersQuery.docs.isNotEmpty;
  } catch (e) {
    // Gérer les erreurs ici, si nécessaire
    print("Erreur lors de la vérification de l'existence de l'utilisateur : $e");
    return false;
  }
}

Future<String> fetchHiddenThingGoogle() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("hidden")
        .limit(2) // Limite la requête au premier document
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot snapshot = querySnapshot.docs.last;
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String? google = userData['google'];
      return google ?? "";
    } else {
      print('Aucun document trouvé dans la collection "hidden"');
      return "";
    }
  } catch (e) {
    print('Erreur lors de la récupération des informations : $e');
    return "";
  }
}

Future<String> fetchHiddenThingApple() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("hidden")
        .limit(2)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot snapshot = querySnapshot.docs.first;
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String? apple = userData['apple'];
      print(apple ?? "");
      return apple ?? "";
    } else {
      print('Aucun document trouvé dans la collection "hidden"');
      return "";
    }
  } catch (e) {
    print('Erreur lors de la récupération des informations : $e');
    return "";
  }
}

// Interrupteur pour activer/désactiver une fonctionnalité (carré où on coche)
class SettingToggle extends StatefulWidget {
  final String title; // Titre de l'option

  const SettingToggle({super.key, required this.title});

  @override
  _SettingToggleState createState() => _SettingToggleState();
}

class _SettingToggleState extends State<SettingToggle> {
  bool isEnabled = true; // État initial de l'interrupteur

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribution des éléments
      children: [
        Text(widget.title, style: const TextStyle(
          fontFamily: 'Arima',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        )
        ),
        Switch(
          value: isEnabled, // État actuel de l'interrupteur
          onChanged: (value) {
            setState(() {
              isEnabled = value; // Change l'état de l'interrupteur
            });
          },
          activeColor: Colors.green, // Couleur lorsque l'interrupteur est activé
        ),
      ],
    );
  }
}

// Liens pour accéder à d'autres pages
class SettingLink extends StatelessWidget {
  final String title; // Titre du lien
  final String? routeName; // Nom de la route pour la navigation

  const SettingLink({super.key, required this.title, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Espacement vertical
      child: InkWell(
        onTap: () {
          if (routeName != null) {
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
                .then((_) {
              Navigator.pushNamed(context, routeName!);
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Marges internes
          decoration: BoxDecoration(
            color: Colors.green[100], // Couleur de fond
            borderRadius: BorderRadius.circular(10), // Coins arrondis
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}


// Menu déroulant pour sélectionner la langue
class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = 'Français'; // Langue par défaut

  // Charger la langue depuis SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selected_language');
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  // Sauvegarder la langue choisie dans SharedPreferences
  Future<void> _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacement vertical
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribution des éléments
        children: [
          Text(selectedLanguage == 'Français' ? 'Langue' : 'Language',
            style: const TextStyle(
              fontFamily: 'Arima',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),

          DropdownButton<String>(
            value: selectedLanguage, // Langue actuelle sélectionnée
            items: <String>['Français', 'English'].map((String value) {
              return DropdownMenuItem<String>(
                value: value, // Valeur de l'élément
                child: Text(value), // Texte affiché dans le menu déroulant
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedLanguage = newValue!; // Change la langue sélectionnée
                _saveLanguage(newValue); // Sauvegarder la langue sélectionnée
              });
              // 🔄 Mettre à jour toute la page
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  //@override
  //void dispose() {
    // TODO: implement dispose
  //  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
  //      .then((_) {});
 //   super.dispose();
  //}

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

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {

  //@override
  //void dispose() {
    // TODO: implement dispose
   // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
   //     .then((_) {});
  //  super.dispose();
 // }

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
