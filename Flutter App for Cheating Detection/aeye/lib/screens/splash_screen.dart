import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aeye/screens/attendent_mode.dart';
import 'package:aeye/screens/automated_mode.dart';
import 'package:aeye/screens/onboarding_screen.dart';
import 'package:aeye/screens/mode_chose.dart';
import '../utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;
  // ignore: constant_identifier_names
  static const String KEYMODE = "Mode";

  @override
  void initState() {
    super.initState();
    _requestPermission();
    checkifLogin();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF600),
                Color(0xFFFFCF07),
                Color(0xFFFFA80F),
                Color(0xFFFE8116),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
      ),
    );
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      //print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  checkifLogin() async {
    auth.authStateChanges().listen((User? user) {
      
      if (user != null && mounted) {
        Currentuid = user.uid;
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var whatMode = sharedPref.getString(KEYMODE);

    Timer(const Duration(seconds: 2), () {
      if (isLogin) {
        if (whatMode != null) {
          if (whatMode == "attendent") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AttendentMode(),
                ));
          } else if (whatMode == "blind") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AutomatedMode(),
                ));
          }
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ModeChose(),
              ));
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ));
      }
    } 
        );
  }
}
