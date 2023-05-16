import 'package:aeye/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aeye/screens/automated_mode.dart';
import 'package:aeye/screens/login_screen.dart';

import 'package:aeye/screens/attendent_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeChose extends StatefulWidget {
  const ModeChose({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ModeChoseState createState() => _ModeChoseState();
}

class _ModeChoseState extends State<ModeChose> {
  Widget _buildChoosethemodeText() {
    return Column(
      children: const <Widget>[
        Text(
          '- Please Choose your user mode -',
          style: TextStyle(
            color: Color.fromARGB(255, 228, 61, 0),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  void attendmodeselect() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(SplashScreenState.KEYMODE, "attendent");
  }

  void blindmodeselect() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(SplashScreenState.KEYMODE, "blind");
  }
  

  Widget _buildAutomatedBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          //Mode selection using shared prefrences

          // var sharedPref = await SharedPreferences.getInstance();
          // sharedPref.setString(SplashScreenState.KEYMODE, "attendent");
          blindmodeselect();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) {
            return const AutomatedMode();
          })));
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'Self Operating Mode',
          style: TextStyle(
            color: Color.fromARGB(255, 228, 61, 0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildAttendentBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          //Mode selection using shared prefrences
          attendmodeselect();
          // var sharedPref = await SharedPreferences.getInstance();
          // sharedPref.setString(SplashScreenState.KEYMODE, "attendent");

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) {
            return const AttendentMode();
          })));
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'Guardian Mode',
          style: TextStyle(
            color: Color.fromARGB(255, 228, 61, 0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutBtn() {
    return GestureDetector(
      onTap: () async {
        // Call the Firebase signOut() method to sign out the user
        await FirebaseAuth.instance.signOut();
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return const LoginScreen();
        })));
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Sign Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // TextSpan(
            //   text: 'Sign Up',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
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
              Center(
                child: SizedBox(
                  //commented below line to bring content in center
                  //height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 150.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Welcome to A-Eye',
                          style: TextStyle(
                            color: Color.fromARGB(255, 228, 61, 0),
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        _buildChoosethemodeText(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildAttendentBtn(),
                        _buildAutomatedBtn(),
                        
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildSignOutBtn(),
                      ],
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
}
