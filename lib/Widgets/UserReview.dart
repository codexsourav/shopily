import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../helpers/getDateTime.dart';

Widget userReview(Map data) {
  return Container(
    padding: EdgeInsets.all(15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: data['user']['dpic'].toString(),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 250, 250, 250),
                    highlightColor: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 243, 243)),
                    ),
                  );
                },
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['user']['name'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    GetDateTime.getDate(data['date']),
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RatingBar.builder(
            initialRating: data['stars'].toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            itemSize: 18,
            ignoreGestures: true,
            allowHalfRating: false,
            itemCount: 5,
            unratedColor: Color.fromARGB(255, 226, 226, 226),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rate) {},
          ),
        ),
        Text(data['msg'] ?? ""),
      ],
    ),
  );
}
