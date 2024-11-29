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
        title: Text("Réglages",
          style: TextStyle(
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
          }, icon: Icon(Icons.logout_rounded, color: Colors.redAccent,))
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
                              'Connexion',
                              style: TextStyle(
                                fontFamily: 'Arima',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                           if(sharedPreferences!.getString("fullname") != null) Text(
                              'Bienvenu ${sharedPreferences!.getString("fullname")},',
                              style: TextStyle(
                                fontFamily: 'Arima',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Espacement
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

                  // Options de réglages avec des interrupteurs
                  const SettingToggle(title: 'Son'),
                  const SettingToggle(title: 'Vibrations'),
                  const SettingToggle(title: 'Musique'),
                  const SettingToggle(title: 'Notifications'),

                  // Menu déroulant pour le choix de la langue
                  const LanguageDropdown(),

                  // Liens vers d'autres pages
                  const SettingLink(title: 'Politique de confidentialité', routeName: '/privacy'),
                  const SettingLink(title: 'Conditions d\'utilisation', routeName: '/terms'),
                  const SettingLink(title: 'Support'),
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
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,

                        child: RichText(
                          text: TextSpan(
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
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: width * 1.7 / 5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(176, 191, 192, 1.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                onPressed: () async {
                                  HapticFeedback.selectionClick();
                                  Navigator.pop(context);
                                },
                                child: Text("RETOURNER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => SettingsPage()));
                                    });
                                  });
                                },
                                child: Icon(Icons.logout_rounded, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
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
          onPressed: () {
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
          child: const Text('Se connecter',
            style: TextStyle(
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
          await sharedPreferences!.setString("bio", snapshot.data()!["bio"] ?? "");
          print("Holaaaa --- ----- ");
          await sharedPreferences!.setString("fullname", snapshot.data()!["fullname"] ?? "");
          await sharedPreferences!.setString("location", snapshot.data()!["location"] ?? "");
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"] ?? "");
          print("Holaaaa  111111111");
          await sharedPreferences!.setString("cabinet", snapshot.data()!["cabinet"] ?? "");
          await sharedPreferences!.setString("doctorTitle", snapshot.data()!["doctorTitle"] ?? "");
          await sharedPreferences!.setString("phoneNumber", snapshot.data()!["phoneNumber"] ?? "");
          print("Holaaaa  2222222222");
          await sharedPreferences!.setString("indicatif", snapshot.data()!["indicatif"] ?? "");
          await sharedPreferences!.setInt("numberofauthentications", snapshot.data()!["numberofauthentications"] ?? 0);
          await sharedPreferences!.setInt("joinDate", snapshot.data()!["joinDate"] ?? 0);
          print("Holaaaa  3333333333");
          await sharedPreferences!.setInt("fareRDV", snapshot.data()!["fareRDV"] ?? 0);
          await sharedPreferences!.setInt("fare", snapshot.data()!["fare"] ?? 0);
          await sharedPreferences!.setInt("newFare", snapshot.data()!["newFare"] ?? 0);
          await sharedPreferences!.setInt("passwordChanged", snapshot.data()!["passwordChanged"] ?? 0);
          await sharedPreferences!.setBool("isDoctor", snapshot.data()!["isDoctor"] ?? false);
          await sharedPreferences!.setBool("urgence", snapshot.data()!["urgence"] ?? false);
          print("Holaaaa  444444444");
          // print("${sharedPreferences!.getString("fullname")!}");
          // print("${sharedPreferences!.getString("location")!}");
          // print("${sharedPreferences!.getString("photoUrl")!}");
          // print("${sharedPreferences!.getString("cabinet")!}");
          // print("${sharedPreferences!.getString("doctorTitle")!}");
          // print("${sharedPreferences!.getString("phoneNumber")!}");
          // print("${sharedPreferences!.getString("indicatif")!}");
          // print("${sharedPreferences!.getInt("numberofauthentications")!}");
          // print("${sharedPreferences!.getInt("joinDate")!}");
          // print("${sharedPreferences!.getInt("fareRDV")!}");
          // print("${sharedPreferences!.getInt("newFare")!}");
          // print("${sharedPreferences!.getInt("fare")!}");
          // print("${sharedPreferences!.getInt("passwordChanged")!}");
          // print("${sharedPreferences!.getBool("isDoctor")!}");
          // print("${sharedPreferences!.getBool("urgence")!}");

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

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => SettingsPage(), fullscreenDialog: true));
        }

        else {
          firebaseAuth.signOut();
          // Navigator.pop(context);
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Votre comptre a été bloqué. Expliquez votre situation à: \n\nsupport@doclinkers.com", timeInSecForIosWeb: 3);
        }
      }

      else
      {
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingsPage(), fullscreenDialog: true));
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
      "userIdentifierApple": userIdentifierApple,
      // "birthdate": DateTime(2000, 11, 9),
    }).whenComplete(() async{

      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences!.setString("uid", uid);
      await sharedPreferences!.setString("email", email);
      await sharedPreferences!.setString("status", "approved");
      await sharedPreferences!.setString("fullname", fullname);
      await sharedPreferences!.setString("photoUrl", photoUrl);
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => SettingsPage()));

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
            Navigator.pushNamed(context, routeName!); // Navigation vers une autre page
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacement vertical
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribution des éléments
        children: [
          const Text('Langue',
            style: TextStyle(
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
              });
            },
          ),
        ],
      ),
    );
  }
}

// Page politique de confidentialité
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
        title: Text('Politique de confidentialité',
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

      body: const Padding(
        padding: EdgeInsets.all(16.0), // Espacement autour du contenu principal
        child: SingleChildScrollView(
          // Permet le défilement si le texte est trop long pour l'écran
          child: Text(
            'Contenu de la politique de confidentialité...',
            style: TextStyle(
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

// Page conditions d'utilisation
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

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
        title: Text('Conditions d\'utilisation',
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
      body: const Padding(
        padding: EdgeInsets.all(16.0), // Marges autour du contenu
        child: SingleChildScrollView(
          // Permet de défiler pour voir tout le contenu
          child: Text(
            'Contenu des conditions d\'utilisation...',
            style: TextStyle(
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