import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
String cloudMessagingServerToken = "";
bool isAdmin = false;

int indexDocx = 1;
bool playOrNot = true;

bool authenticated = false;
bool canAuth = true;

bool setPortrait = false;
String ipAddress = "";

enum MyCountry {france, japan, laReunion, turkish, china, unitedStates}
MyCountry myCountry = MyCountry.france;

enum DrugFrequency {once, twice, onceADay, twiceADay, threeTimesADay, oncePer2Days, oncePer3Days, oncePerWeek, twicePerWeek, afterEachMeal, afterBreakfast, afterLunch, afterDinner, beforeBreakfast, beforeLunch, beforeDinner}

bool hasInternet = false;

Map<String, String> numbersToDisplay = {};

Map<String, String> frenchNumbers = {
  "Police secours": "17",
  "SAMU": "15",
  "Numéro d'urgence européen": "112",
  "Sapeurs pompiers": "18",
  "Numéro d'urgence pour les personnes sourdes et malentendantes": "114",
  "Samu social": "115",
  "Enfance en danger": "119",
};

//Japon, La Réunion,

Map<String, String> japaneseNumbers = {
  "Police": "110",
  "Pompiers": "119",
  "Questions d'urgence": "7119(Gratuit) - 9110(Payant)",
  "Tokyo Fire Department": "03 3212 2323",
};

Map<String, String> laReunionNumbers = {
  "Toute la météo de l’île": "08 92 68 08 08",
  "Appel d’urgence européen": "112",
  "Police ou gendarmerie": "17",
  "Pompiers": "18",
  "SAMU (urgence médicale)": "15",
  "Secours en montagne": "0262 930 930",
  "Le point sur les cyclones": "08 97 65 01 01",
};

Map<String, String> turkishNumbers = {
  "Police secours": "155",
  "Urgences(Ambulance)": "112",
  "Pompiers": "110",
  "Gendarmerie (zone rurale)": "156",
  "N° d’urgence du consulat général de France (uniquement en cas d’urgence avérée et grave) :": "+90 532 311 06 19",
};

Map<String, String> chineseNumbers = {
  "Police (appel)": "110",
  "Police (sms)": "12110",
  "Ambulance": "120",
  "Pompiers": "119",
  "Accident de la route": "122",
  "Association francophone Solidarité Shanghai :": "+86 136 8161 7895",
  "Urgence consulat :": "136 0160 7871",
};

Map<String, String> unitedStatesNumbers = {
  "Toutes les urgences": "911",
  "Assistance téléphonique pour la santé mentale": "988",
  "Ambassade de France aux USA": "+ 1 202 944 6000",
  "Pompiers": "119",
  "Accident de la route": "122",
  "Association francophone Solidarité Shanghai :": "+86 136 8161 7895",
  "Urgence consulat :": "136 0160 7871",
};