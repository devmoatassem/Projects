// import 'package:aeye/screens/show_sos_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:aeye/utilities/constants.dart';
// import 'package:firebase_database/firebase_database.dart';
// //import 'package:cloud_firestore/cloud_firestore.dart';

// class AddContacts extends StatefulWidget {
//   const AddContacts({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AddContactsState createState() => _AddContactsState();
// }

// class _AddContactsState extends State<AddContacts> {
//   final _nameController = TextEditingController();
//   final _contactControler = TextEditingController();
//   late DatabaseReference dbRef;

//   @override
//   void initState() {
//     super.initState();
//     dbRef = FirebaseDatabase.instance.ref().child(Currentuid);
//   }

  

//   Widget _buildFullName() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         const Text(
//           'Full Name',
//           style: kLabelStyle,
//         ),
//         const SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             controller: _nameController,
//             //obscureText: true,
//             style: const TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.person,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter Name',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPhoneNo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const Text(
//           'Phone No',
//           style: kLabelStyle,
//         ),
//         const SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             controller: _contactControler,
//             //obscureText: true,
//             style: const TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.mobile_friendly,
//                 color: Colors.white,
//               ),
//               hintText: '923001122333',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAddBtn() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () async {
//           Map<String, String> SOSContacts = {
//                     'name': _nameController.text,
//                     'contact': _contactControler.text,
                   
//                   };
 
//                   dbRef.push().set(SOSContacts);
            
//           Navigator.pushReplacement(context,
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
//           'Add',
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
//                           'Add SOS Contact',
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 228, 61, 0),
//                             fontFamily: 'OpenSans',
//                             fontSize: 30.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 25.0),
//                         _buildFullName(),
//                         SizedBox(height: 25.0),
//                         _buildPhoneNo(),
//                         SizedBox(height: 25.0),
//                         _buildAddBtn(),
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
