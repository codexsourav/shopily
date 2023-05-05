import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

Widget loader({double width = 10.0, double height = 10.0}) {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 250, 250, 250),
    highlightColor: const Color.fromARGB(255, 255, 255, 255),
    child: Container(
      width: width,
      height: height,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 243, 243, 243)),
    ),
  );
}
