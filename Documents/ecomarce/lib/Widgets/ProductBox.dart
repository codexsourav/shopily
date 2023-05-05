import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/cart/managecart.dart';

class ProductBox extends StatefulWidget {
  final data;
  const ProductBox({super.key, required this.data});

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  var data;
  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 250, 250, 250),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 10),
                  child: SizedBox(
                    height: 80,
                    child: CachedNetworkImage(
                      imageUrl: data['poster'],
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 250, 250, 250),
                          highlightColor: Color.fromARGB(255, 255, 255, 255),
                          child: Container(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['title'] ?? "Null",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 61, 61, 61),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                    initialRating: data['rating'].toDouble(),
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    itemSize: 15,
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
                Text(
                  "₹ " + data['mainprice'].toString() + ".00",
                  style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 121, 121, 121),
                      decoration: TextDecoration.lineThrough),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    backgroundColor: Colors.black,
                    label: Text(
                      "₹ " + data['price'].toString() + ".00",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Consumer<ManagecartProvider>(
              builder: (context, value, child) {
                bool isid = value.CartItems.contains(data['_id']);
                return IconButton(
                  onPressed: () {
                    value.AddRemove(data);
                  },
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    isid
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 18,
                    color: isid
                        ? Color.fromARGB(255, 231, 83, 83)
                        : Color.fromARGB(255, 216, 216, 216),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
