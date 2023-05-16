// import 'package:aeye/screens/mode_chose.dart';
// import 'package:aeye/screens/show_sos_contacts.dart';
// import 'package:aeye/screens/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:aeye/screens/show_sos_pictures.dart';
// import 'package:location/location.dart' as loc;
// import 'package:aeye/utilities/mymap.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AttendentMode extends StatefulWidget {
//   const AttendentMode({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AttendentModeState createState() => _AttendentModeState();
// }

// class _AttendentModeState extends State<AttendentMode> {
//   final loc.Location location = loc.Location();
//   //StreamSubscription<loc.LocationData>? _locationSubscription;

//   @override
//   void initState() {
//     super.initState();

//     location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
//     location.enableBackgroundMode(enable: true);
//   }

//   void exitmodeselect() async {
//     var sharedPref = await SharedPreferences.getInstance();
//     sharedPref.remove(SplashScreenState.KEYMODE);
//   }

//   // Widget _buildReportIssueBtn() {
//   //   return Container(
//   //     alignment: Alignment.centerRight,
//   //     child: TextButton(
//   //       onPressed: () => print('Forgot Password Button Pressed'),
//   //       style: ElevatedButton.styleFrom(
//   //         padding: const EdgeInsets.only(right: 0.0),
//   //       ),
//   //       child: const Text(
//   //         'Have an Issue? Report Now_',
//   //         style: kLabelStyle,
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildBtn1() {
//   //   return Container(
//   //     padding: const EdgeInsets.symmetric(vertical: 25.0),
//   //     width: double.infinity,
//   //     child: ElevatedButton(
//   //       onPressed: () => print('Button 1 Pressed'),
//   //       style: ElevatedButton.styleFrom(
//   //         elevation: 5.0,
//   //         backgroundColor: Colors.white,

//   //         padding: const EdgeInsets.all(15.0),
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(30.0),
//   //         ),

//   //       ),
//   //       child: const Text(
//   //           'Connect the Device',
//   //           style: TextStyle(
//   //             color:  Color(0xFF5B16D0),
//   //             letterSpacing: 1.5,
//   //             fontSize: 18.0,
//   //             fontWeight: FontWeight.bold,
//   //             fontFamily: 'OpenSans',
//   //           ),
//   //         ),
//   //     ),
//   //   );
//   // }

//   Widget _gotoPictures() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: ((context) {
//             return const ShowPictures();
//           })));
//         },
//         //=> print('Button 2 Pressed'),
//         style: ElevatedButton.styleFrom(
//           elevation: 5.0,
//           backgroundColor: Colors.white,
//           padding: const EdgeInsets.all(15.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//         ),
//         child: const Text(
//           'Latest Pictures',
//           style: TextStyle(
//             color: Color.fromARGB(255, 228, 61, 0),
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _seeLocation() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('location').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return Container(
//             padding: const EdgeInsets.all(0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => MyMap(snapshot.data!.docs[0].id)));
//               },
//               style: ElevatedButton.styleFrom(
//                 elevation: 5.0,
//                 backgroundColor: Colors.white,
//                 padding: const EdgeInsets.all(15.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//               child: const Text(
//                 'Track Location',
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 228, 61, 0),
//                   letterSpacing: 1.5,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'OpenSans',
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Widget _seeLocation() {
//   //   return Container(
//   //       padding: const EdgeInsets.symmetric(vertical: 25.0),
//   //       width: double.infinity,
//   //       child: StreamBuilder(
//   //         stream: FirebaseFirestore.instance.collection('location').snapshots(),
//   //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//   //           if (!snapshot.hasData) {
//   //             return const Center(child: CircularProgressIndicator());
//   //           }
//   //           return ListView.builder(
//   //               scrollDirection: Axis.vertical,
//   //               shrinkWrap: true,
//   //               itemCount: snapshot.data?.docs.length,
//   //               itemBuilder: (context, index) {
//   //                 return Padding(
//   //                     padding: const EdgeInsets.all(0),
//   //                     // title:
//   //                     //     Text(snapshot.data!.docs[index]['name'].toString()),
//   //                     // subtitle: Row(
//   //                     //   // children: [
//   //                     //   //   Text(snapshot.data!.docs[index]['latitude']
//   //                     //   //       .toString()),
//   //                     //   //   const SizedBox(
//   //                     //   //     width: 20,
//   //                     //   //   ),
//   //                     //   //   Text(snapshot.data!.docs[index]['longitude']
//   //                     //   //       .toString()),
//   //                     //   // ],
//   //                     // ),
//   //                     child: ElevatedButton(
//   //                       onPressed: () {
//   //                         Navigator.of(context).push(MaterialPageRoute(
//   //                             builder: (context) =>
//   //                                 MyMap(snapshot.data!.docs[index].id)));
//   //                       },
//   //                       style: ElevatedButton.styleFrom(
//   //                         elevation: 5.0,
//   //                         backgroundColor: Colors.white,
//   //                         padding: const EdgeInsets.all(15.0),
//   //                         shape: RoundedRectangleBorder(
//   //                           borderRadius: BorderRadius.circular(30.0),
//   //                         ),
//   //                       ),
//   //                       child: const Text(
//   //                         'Track Location',
//   //                         style: TextStyle(
//   //                           color: Color(0xFF5B16D0),
//   //                           letterSpacing: 1.5,
//   //                           fontSize: 18.0,
//   //                           fontWeight: FontWeight.bold,
//   //                           fontFamily: 'OpenSans',
//   //                         ),
//   //                       ),
//   //                     ));
//   //               });
//   //         },
//   //       ));
//   // }

//   Widget _buildBtn4() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () async {
//           Navigator.push(context,
//               MaterialPageRoute(builder: ((context) {
//             return ShowContacts();
//           })));
//         },
//         style: ElevatedButton.styleFrom(
//           elevation: 5.0,
//           backgroundColor: Colors.white,
//           padding: const EdgeInsets.all(15.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//         ),
//         child: const Text(
//           'Add/Remove SOS Contacts',
//           style: TextStyle(
//             color: Color.fromARGB(255, 228, 61, 0),
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildExitBtn() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 25.0),
//       width: 150,
//       child: ElevatedButton(
//         onPressed: () {
//           exitmodeselect();
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: ((context) {
//             return const ModeChose();
//           })));
//         },
//         style: ElevatedButton.styleFrom(
//           elevation: 5.0,
//           backgroundColor: Colors.white,
//           padding: const EdgeInsets.all(15.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//         ),
//         child: const Text(
//           '- Exit -',
//           style: TextStyle(
//             color: Color.fromARGB(255, 228, 61, 0),
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xFFFFF600),
//                 Color(0xFFFFCF07),
//                 Color(0xFFFFA80F),
//                 Color(0xFFFE8116),
//                     ],
//                     stops: [0.1, 0.4, 0.7, 0.9],
//                   ),
//                 ),
//               ),
//               Center(
//                 child: SizedBox(
//                   //height: double.infinity,
//                   child: SingleChildScrollView(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40.0,
//                       vertical: 50.0,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         const Text(
//                           'Hello Attendent',
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 228, 61, 0),
//                             fontFamily: 'OpenSans',
//                             fontSize: 30.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         // const SizedBox(height: 30.0),
//                         // _buildBtn1(),
//                         const SizedBox(
//                           height: 30.0,
//                         ),
//                         _gotoPictures(),
//                         const SizedBox(
//                           height: 30.0,
//                         ),
//                         _seeLocation(),
//                         const SizedBox(
//                           height: 30.0,
//                         ),
//                         _buildBtn4(),
//                         const SizedBox(
//                           height: 30.0,
//                         ),
//                         _buildExitBtn(),
//                         // const SizedBox(
//                         //   height: 30.0,
//                         // ),

//                         // _buildReportIssueBtn(),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
