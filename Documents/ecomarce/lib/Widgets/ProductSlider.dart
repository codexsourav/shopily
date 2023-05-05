import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductSlider extends StatelessWidget {
  final List urls;
  const ProductSlider(this.urls, {super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        autoPlay: false,
        disableCenter: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
      ),
      items: urls.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
              child: CachedNetworkImage(
                imageUrl: i.toString(),
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 255, 255, 255),
                    highlightColor: Color.fromARGB(255, 245, 245, 245),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  );
                },
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
