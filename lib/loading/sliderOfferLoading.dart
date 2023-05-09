import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget sliderOfferLoading(context) {
  return Container(
    child: CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: false,
      ),
      items: [3, 2, 1].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Shimmer.fromColors(
                baseColor: Color.fromARGB(255, 250, 250, 250),
                highlightColor: Color.fromARGB(255, 255, 255, 255),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 243, 243, 243)),
                ),
              ),
            );
          },
        );
      }).toList(),
    ),
  );
}
