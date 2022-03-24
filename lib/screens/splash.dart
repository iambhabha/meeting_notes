import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cmp/Notes/notes_page.dart';
import 'package:flutter/material.dart';

class splashgif extends StatefulWidget {
  const splashgif({Key? key}) : super(key: key);

  @override
  State<splashgif> createState() => _splashgifState();
}

class _splashgifState extends State<splashgif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        width: 400,
        child: AnimatedSplashScreen(
          splash: Image.asset('assets/Preloader IV.gif'),
          nextScreen: NotesPage(),
          splashTransition: SplashTransition.sizeTransition,
          splashIconSize: 100,
          backgroundColor: Colors.black,
          duration: 5000,
          // seconds: 8,
          // backgroundColor: Colors.black,
          // image: Image.asset('assets/Preloader IV.gif'),
          // loaderColor: Colors.white,
          // loadingText: const Text("Welcome To Meeting Notes"),
          // navigateAfterSeconds: NotesPage(),
        ),
      ),
    );
  }
}
