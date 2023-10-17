 import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
   double get screenWidth => MediaQuery.of(this).size.width * 1 ;
  double get screenHeight => MediaQuery.of(this).size.height * 1 ;
}