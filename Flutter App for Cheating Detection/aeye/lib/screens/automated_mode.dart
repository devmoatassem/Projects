import 'package:aeye/screens/mode_chose.dart';
import 'package:aeye/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:background_sms/background_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shake/shake.dart';

import '../utilities/constants.dart';

class AutomatedMode extends StatefulWidget {
  const AutomatedMode({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AutomatedModeState createState() => _AutomatedModeState();
}

class _AutomatedModeState extends State<AutomatedMode> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  bool buttonlocation = true;
  bool buttonSoS = true;
  final databaseRef =
      FirebaseDatabase.instance.ref().child(Currentuid);
  List<dynamic> list = [];

  //variable to give good looks to switch button
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    _getPermission();
    getListValues();
    activatelocservice(buttonlocation);
    activateshakeservice(buttonSoS);
  }

  void activatelocservice(onOff) {
    if (onOff) {
      _listenLocation();
      location.changeSettings(
          interval: 500, accuracy: loc.LocationAccuracy.high);
      location.enableBackgroundMode(enable: true);
    } else {
      _stopListening();
    }
  }

  void exitmodeselect() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(SplashScreenState.KEYMODE);
  }

  //Functions to track location
  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      //print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc(Currentuid).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 2);
    if (result == SmsStatus.sent) {
      Fluttertoast.showToast(msg: "SOS Messages Sent");

      //Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "Unable to send Messages");
    }
  }

  void getListValues() {
    databaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map =
            event.snapshot.value as Map<dynamic, dynamic>;
        list = map.values.toList();
      }
    });
  }

  Future<void> sendMessageToList() async {
    if (list.isEmpty) {
      Fluttertoast.showToast(msg: "emergency contact is empty");
    } else {
      String messageBody = "SOS Alert Testing First time to a list of numbers";

      if (await _isPermissionGranted()) {
        for (int i = 0; i < list.length; i++) {
          _sendSms(list[i]['contact'], messageBody);
          print(list[i]['contact']);
        }
      } else {
        Fluttertoast.showToast(msg: "something wrong");
      }
    }
  }

  void activateshakeservice(bool shakeon) {
    if (shakeon) {
      detector ??= ShakeDetector.waitForStart(
        onPhoneShake: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Shake Detected!'),
            ),
          );

          // Do stuff on phone shake
          sendMessageToList();
        },
        minimumShakeCount: 1,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        shakeThresholdGravity: 2.7,
      );
      detector!.startListening();
    } else {
      detector!.stopListening();
    }
  }

  Widget _buildExtraText() {
    return Column(
      children: const <Widget>[
        Text(
          '- User in automated mode -',
          style: TextStyle(
            color: Color.fromARGB(255, 228, 61, 0),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildExitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          _stopListening();
          exitmodeselect();

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) {
            return const ModeChose();
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
          '- Exit -',
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

  Widget _buildSwitchBtnMsg() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 5),
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color

        borderRadius: BorderRadius.circular(30), // Set the border radius
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 49, 48, 48)
                .withOpacity(0.5), // Set the shadow color
            spreadRadius: 2, // Set the spread radius of the shadow
            blurRadius: 5, // Set the blur radius of the shadow
            offset: const Offset(0, 3), // Set the offset of the shadow
          ),
        ],
      ),
      child: ListTile(
        title: const Text(
          "SOS Message",
          style: TextStyle(
            color: Color.fromARGB(255, 228, 61, 0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        trailing: Theme(
          data: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color.fromARGB(255, 228, 61, 0),
          ),
          child: Switch(
            thumbIcon: thumbIcon,
            value: buttonSoS,
            onChanged: (bool value) {
              activateshakeservice(value);
              setState(() {
                buttonSoS = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchBtnLoc() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 5),
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color

        borderRadius: BorderRadius.circular(30), // Set the border radius
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 49, 48, 48)
                .withOpacity(0.5), // Set the shadow color
            spreadRadius: 2, // Set the spread radius of the shadow
            blurRadius: 5, // Set the blur radius of the shadow
            offset: const Offset(0, 3), // Set the offset of the shadow
          ),
        ],
      ),
      child: ListTile(
        title: const Text(
          "Location Service",
          style: TextStyle(
            color: Color.fromARGB(255, 228, 61, 0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        trailing: Theme(
          data: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color.fromARGB(255, 228, 61, 0),
          ),
          child: Switch(
            thumbIcon: thumbIcon,
            value: buttonlocation,
            onChanged: (bool value) {
              activatelocservice(value);
              setState(() {
                buttonlocation = value;
              });
            },
          ),
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
                  //height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 50.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "You're in Automated Mode",
                          style: TextStyle(
                            color: Color.fromARGB(255, 228, 61, 0),
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        _buildExtraText(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildSwitchBtnLoc(),
                        const SizedBox(height: 30.0),
                        _buildSwitchBtnMsg(),
                        const SizedBox(height: 30.0),
                        _buildExitBtn()
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
