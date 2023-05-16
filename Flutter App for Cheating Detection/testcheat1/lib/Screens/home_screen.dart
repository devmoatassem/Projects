import 'package:flutter/material.dart';

class WelcomeHomeScreen extends StatelessWidget {
  const WelcomeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9c8cd3),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70)),
                  ),
                  child: const Center(
                    child: Image(
                      image: AssetImage(
                        'images/cheat1.png',
                      ),
                      width: 270,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height /2.666,
                decoration: const BoxDecoration(
                  color: Color(0xFF9c8cd3),
                  
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height /2.666,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70)
                  )
                ),
                
                child: Column(children: [
                  const SizedBox(height: 45),
                  const Text(
                    "Ensure Academic Integrity",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      wordSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(padding: 
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Text("Our Exam Cheating Detector App uses advanced technology to ensure fair and honest exams by detecting cheating behavior in real-time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.6),
                  ),) 
                  ),
                  const SizedBox(height: 30), 
                  Material(
                    color: const Color(0xFF9c8cd3),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,horizontal: 80),
                          child: const Text(
                            "Check Pictures",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),

                     
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
