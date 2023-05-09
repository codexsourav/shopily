import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget productBoxLaoding(context) {
  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 6,
    padding: EdgeInsets.all(10),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.width / 600,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 250, 250, 250),
          highlightColor: Color.fromARGB(255, 255, 255, 255),
          child: Container(
            height: 550.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 250, 250),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
    },
  );
}
