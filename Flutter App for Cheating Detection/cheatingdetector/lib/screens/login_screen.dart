// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:aeye/utilities/constants.dart';
// import 'package:aeye/screens/signup_screen.dart';
// import 'package:aeye/screens/mode_chose.dart';
// import 'package:firebase_auth/firebase_auth.dart';



// enum AvailableModes {attendent, blind }

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {

//   // Define variables for email and password
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   // Define a variable for the FirebaseAuth instance
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Widget _buildEmailTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const Text(
//           'Email',
//           style: kLabelStyle,
//         ),
//         const SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             //adding email controller
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             style: const TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.email,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Email',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const Text(
//           'Password',
//           style: kLabelStyle,
//         ),
//         const SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             controller: _passwordController,
//             obscureText: true,
//             style: const TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Password',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget _buildForgotPasswordBtn() {
//   //   return Container(
//   //     alignment: Alignment.centerRight,
//   //     child: TextButton(
//   //       onPressed: () => print('Forgot Password Button Pressed'),
//   //       style: ElevatedButton.styleFrom(
//   //         padding: const EdgeInsets.only(right: 0.0),
//   //       ),

//   //       child: Text(
//   //         'Forgot Password?',
//   //         style: kLabelStyle,
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildRememberMeCheckbox() {
//   //   return SizedBox(
//   //     height: 20.0,
//   //     child: Row(
//   //       children: <Widget>[
//   //         Theme(
//   //           data: ThemeData(unselectedWidgetColor: Colors.white),
//   //           child: Checkbox(
//   //             value: _rememberMode,
//   //             checkColor: const Color(0xFF5B16D0),
//   //             activeColor: Colors.white,
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 _rememberMode = value;
//   //               });
//   //             },
//   //           ),
//   //         ),
//   //         const Text(
//   //           'Remember me',
//   //           style: kLabelStyle,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   //Radio buttons
//   // Widget _buildModeChoseRadio() {
//   //   return SizedBox(
//   //       //height: 20.0,
//   //       child: Row(
//   //         children: <Widget>[
//   //           Theme(
//   //             data: ThemeData(unselectedWidgetColor: Colors.white),
//   //             child: Expanded(
//   //               child: RadioListTile<AvailableModes>(
//   //                 title: const Text(
//   //                   'Attendent',
//   //                   style: kLabelStyle,
//   //                 ),
//   //                 value: AvailableModes.attendent,
//   //                 groupValue: _rememberMode,
//   //                 activeColor: Colors.white,
//   //                 //tileColor: Colors.deepPurple.shade50,
//   //                 dense: true,

//   //                 onChanged: (AvailableModes? value) {
//   //                   setState(() {
//   //                     _rememberMode = value;
//   //                   });
//   //                 },
//   //                 //contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
//   //               ),
//   //             ),
//   //           ),
            
//   //           Theme(
//   //             data: ThemeData(unselectedWidgetColor: Colors.white),
//   //             child: Expanded(
//   //               child: RadioListTile(
//   //                 title: const Text(
//   //                   'Blind',
//   //                   style: kLabelStyle,
//   //                 ),
//   //                 value: AvailableModes.blind,
//   //                 groupValue: _rememberMode,
//   //                 activeColor: Colors.white,
//   //                 //tileColor: Colors.deepPurple.shade50,
//   //                 dense: true,
//   //                 onChanged: (AvailableModes? value) {
//   //                   setState(() {
//   //                     _rememberMode = value;
//   //                   });
//   //                 },
//   //                 //contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ));
//   // }

//   Widget _buildLoginBtn() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () async {
//           try {
//             // Call the Firebase signInWithEmailAndPassword() method to sign in the user
//             UserCredential userCredential =
//                 await _auth.signInWithEmailAndPassword(
//               email: _emailController.text,
//               password: _passwordController.text,
//             );
//             // If successful, navigate to the home screen
//             //Navigator.of(context).pushReplacementNamed('/home');
//             // ignore: use_build_context_synchronously
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
//               return const ModeChose();
//             })));
//           } on FirebaseAuthException catch (e) {
//             if (e.code == 'user-not-found') {
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 content: Text('No user found for that email.'),
//                 duration: Duration(seconds: 3),
//               ));
//             } else if (e.code == 'wrong-password') {
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 content: Text('Wrong password provided for that user.'),
//                 duration: Duration(seconds: 3),
//               ));
//             }
//           }
//         },
//         //   {
//         //   Navigator.push(context, MaterialPageRoute(builder: ((context) {
//         //               return mode_chose();
//         //             }) ));
//         // },
//         style: ElevatedButton.styleFrom(
//           elevation: 5.0,
//           backgroundColor: Colors.white,
//           padding: const EdgeInsets.all(15.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//         ),
//         child: const Text(
//           'LOGIN',
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

//   Widget _buildSignupBtn() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: ((context) {
//           return const SignupScreen();
//         })));
//       },
//       child: RichText(
//         text: const TextSpan(
//           children: [
//             TextSpan(
//               text: 'Don\'t have an Account? ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             TextSpan(
//               text: 'Sign Up',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
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
//                           'Sign In',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'OpenSans',
//                             fontSize: 30.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 30.0),
//                         _buildEmailTF(),
//                         const SizedBox(
//                           height: 30.0,
//                         ),
//                         _buildPasswordTF(),
//                         const SizedBox(
//                           height: 30.0,
//                         ),
//                         // _buildForgotPasswordBtn(),
//                         //_buildRememberMeCheckbox(),
//                         // const SizedBox(
//                         //   height: 30.0,
//                         // ),
//                         // _buildModeChoseRadio(),
//                         const SizedBox(
//                           height: 30.0,
//                         ),
//                         _buildLoginBtn(),
//                         //_buildSignInWithText(),
//                         //_buildSocialBtnRow(),
//                         _buildSignupBtn(),
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
