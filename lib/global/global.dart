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

enum DrugFrequency {once, twice, onceADay, twiceADay, threeTimesADay, oncePer2Days, oncePer3Days, oncePerWeek, twicePerWeek, afterEachMeal, afterBreakfast, afterLunch, afterDinner, beforeBreakfast, beforeLunch, beforeDinner}

bool hasInternet = false;