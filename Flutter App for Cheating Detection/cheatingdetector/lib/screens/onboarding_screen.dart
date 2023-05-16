// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:aeye/utilities/styles.dart';
// import 'package:aeye/screens/signup_screen.dart';
// import 'package:aeye/screens/login_screen.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final int _numPages = 3;
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;

//   List<Widget> _buildPageIndicator() {
//     List<Widget> list = [];
//     for (int i = 0; i < _numPages; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       height: 8.0,
//       width: isActive ? 24.0 : 16.0,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.white : Color.fromARGB(255, 228, 61, 0),
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.1, 0.4, 0.7, 0.9],
//               colors: [
//                 Color(0xFFFFF600),
//                 Color(0xFFFFCF07),
//                 Color(0xFFFFA80F),
//                 Color(0xFFFE8116),
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: ((context) {
//                         return const LoginScreen();
//                       })));
//                     },
//                     child: const Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 228, 61, 0),
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 600.0,
//                   child: PageView(
//                     physics: const ClampingScrollPhysics(),
//                     controller: _pageController,
//                     onPageChanged: (int page) {
//                       setState(() {
//                         _currentPage = page;
//                       });
//                     },
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const <Widget>[
//                             Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/onboarding0.png',
//                                 ),
//                                 height: 300.0,
//                                 width: 300.0,
//                               ),
//                             ),
//                             SizedBox(height: 30.0),
//                             Text(
//                               'A Worthwhile Product\nfor Homo sapiens',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 15.0),
//                             Text(
//                               'Providing a cost effective product at your service to make your life at ease.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const <Widget>[
//                             Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/onboarding1.png',
//                                 ),
//                                 height: 300.0,
//                                 width: 300.0,
//                               ),
//                             ),
//                             SizedBox(height: 30.0),
//                             Text(
//                               'Live your life smarter\nwith us!',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 15.0),
//                             Text(
//                               'Processes like Human intelligence to provide better outcomes in real time.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const <Widget>[
//                             Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/onboarding2.png',
//                                 ),
//                                 height: 300.0,
//                                 width: 300.0,
//                               ),
//                             ),
//                             SizedBox(height: 30.0),
//                             Text(
//                               'Get a new experience\nof imagination',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 15.0),
//                             Text(
//                               'Vochsafing the blind person with the potential to manifest the surroundings in a better way and excel in their life.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: _buildPageIndicator(),
//                 ),
//                 _currentPage != _numPages - 1
//                     ? Expanded(
//                         child: Align(
//                           alignment: FractionalOffset.bottomRight,
//                           child: TextButton(
//                             onPressed: () {
//                               _pageController.nextPage(
//                                 duration: const Duration(milliseconds: 500),
//                                 curve: Curves.ease,
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: const <Widget>[
//                                 Text(
//                                   'Next',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22.0,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10.0),
//                                 Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.white,
//                                   size: 30.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     : const Text(''),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomSheet: _currentPage == _numPages - 1
//           ? Container(
//               height: 100.0,
//               width: double.infinity,
//               color: Colors.white,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: ((context) {
//                     return const SignupScreen();
//                   })));
//                 },
                
//                 child: const Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 30.0),
//                     child: Text(
//                       'Get Started',
//                       style: TextStyle(
//                         color: Color(0xFFFE5A1D),
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           : const Text(''),
//     );
//   }
// }
