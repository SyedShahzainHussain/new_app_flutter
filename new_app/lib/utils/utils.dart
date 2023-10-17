import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class Utils {
  static spinkit() {
    return const SpinKitCircle(
      size: 50,
      color: Colors.blue,
    );
  }

static Widget showShimmer(BuildContext context,height,width,) {
  return Shimmer.fromColors(
    baseColor: Colors.grey, // Darker color
    highlightColor: Colors.grey.shade300, // Lighter color
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
        color: Colors.white, // Set the background color
      ),
    ),
  );
}

}
