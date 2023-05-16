import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aeye/utilities/constants.dart';
import 'package:aeye/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //final _nameController = TextEditingController();
  // Define variables for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Define a variable for the FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Widget _buildFullName() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       const Text(
  //         'Full Name',
  //         style: kLabelStyle,
  //       ),
  //       const SizedBox(height: 10.0),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: kBoxDecorationStyle,
  //         height: 60.0,
  //         child: TextField(
  //           controller: _nameController,
  //           obscureText: true,
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontFamily: 'OpenSans',
  //           ),
  //           decoration: const InputDecoration(
  //             border: InputBorder.none,
  //             contentPadding: EdgeInsets.only(top: 14.0),
  //             prefixIcon: Icon(
  //               Icons.person,
  //               color: Colors.white,
  //             ),
  //             hintText: 'Enter your Name',
  //             hintStyle: kHintTextStyle,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildPhoneNo() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       const Text(
  //         'Phone No',
  //         style: kLabelStyle,
  //       ),
  //       const SizedBox(height: 10.0),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: kBoxDecorationStyle,
  //         height: 60.0,
  //         child: const TextField(
  //           obscureText: true,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontFamily: 'OpenSans',
  //           ),
  //           decoration: InputDecoration(
  //             border: InputBorder.none,
  //             contentPadding: EdgeInsets.only(top: 14.0),
  //             prefixIcon: Icon(
  //               Icons.mobile_friendly,
  //               color: Colors.white,
  //             ),
  //             hintText: 'Enter your Phone No',
  //             hintStyle: kHintTextStyle,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Confirm Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Confirm Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_passwordController.text != _confirmPasswordController.text) {
            // Passwords do not match
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Passwords do not match'),
                duration: Duration(seconds: 3),
              ),
            );
            return;
          }

          try {
            // Create user with email and password
            UserCredential userCredential =
                await _auth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);

            // Update user profile with name
            //await userCredential.user.updateProfile(displayName: name);

            // Navigate to home screen
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
              return const LoginScreen();
            })));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Password is took weak'),
                duration: Duration(seconds: 3),
              ));
            } else if (e.code == 'email-already-in-use') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Email already in use, please try sign-in'),
                duration: Duration(seconds: 3),
              ));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
              duration: const Duration(seconds: 3),
            ));
          }
          // Navigator.push(context, MaterialPageRoute(builder: ((context) {
          //             return mode_chose();
          //           }) ));
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
          'REGISTER',
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

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return const LoginScreen();
        })));
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        //_buildFullName(),
                        //SizedBox(height: 25.0),
                        //_buildPhoneNo(),
                        //SizedBox(height: 25.0),
                        _buildEmailTF(),
                        const SizedBox(height: 25.0),
                        _buildPasswordTF(),
                        const SizedBox(
                          height: 25.0,
                        ),
                        _buildConfirmPasswordTF(),
                        const SizedBox(height: 25.0),
                        _buildRegisterBtn(),
                        _buildSignInBtn(),
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
