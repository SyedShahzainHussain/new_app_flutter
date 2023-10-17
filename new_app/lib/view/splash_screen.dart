import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/extension/media_query_extension.dart';
import 'package:new_app/view/home_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  HomeScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_pic.jpg',
            width: context.screenWidth * .9,
            height: context.screenHeight * .5,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: context.screenHeight * 0.04,
          ),
          Text(
            "TOP HEADLINES",
            style: GoogleFonts.anton(
              letterSpacing: .6,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(
            height: context.screenHeight * 0.04,
          ),
          const SpinKitChasingDots(
            color: Colors.blue,
            size: 40,
          ),
        ],
      ),
    ));
  }
}
