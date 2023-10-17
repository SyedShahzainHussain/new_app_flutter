import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/extension/media_query_extension.dart';

class InternetErrorWidget extends StatefulWidget {
  const InternetErrorWidget({super.key});

  @override
  State<InternetErrorWidget> createState() => _InternetErrorWidgetState();
}

class _InternetErrorWidgetState extends State<InternetErrorWidget> {
  bool showText = true;

  @override
  void initState() {
    super.initState();

    // Simulate a delay and then hide the text
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        showText = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/5363928.png',
                width: context.screenWidth * .8,
                height: context.screenHeight * .5,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: context.screenHeight * .01,
            ),
            AnimatedScale(
                scale: showText ? 1.5 : 1.0, // Scale only if showText is true
                curve: Curves.easeInOut,
                duration: Duration(seconds: 4),
                child: Text(
                  "No Internet connection",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                )
                // Hide the text if showText is false
                ),
          ]),
    );
  }
}
