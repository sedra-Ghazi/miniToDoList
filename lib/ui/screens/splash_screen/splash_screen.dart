import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/ui/screens/home_page/home_page.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

   @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds then navigate
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      

      backgroundColor: Colors.white,

      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            
            ),
          
        ),
      ),
    );
  }
}
 
