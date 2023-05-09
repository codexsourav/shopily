import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

Widget sliderOffer(context, {required List data}) {
  return CarouselSlider(
    options: CarouselOptions(
      height: 180,
      autoPlay: true,
    ),
    items: data.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context)
                    .push(Uri(path: '/product/' + i['productId']).toString());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 243, 243, 243)),
                child: CachedNetworkImage(
                  imageUrl: i['image'],
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Shimmer.fromColors(
                      baseColor: Color.fromARGB(255, 250, 250, 250),
                      highlightColor: Color.fromARGB(255, 255, 255, 255),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 243, 243)),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}
