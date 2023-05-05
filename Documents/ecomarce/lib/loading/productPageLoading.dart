import 'package:flutter/material.dart';
import 'Loder.dart';

class ProductPageLoading extends StatelessWidget {
  const ProductPageLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loader(height: 300, width: MediaQuery.of(context).size.width),
            Padding(
              padding: const EdgeInsets.all(15),
              child:
                  loader(height: 30, width: MediaQuery.of(context).size.width),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  loader(width: 80, height: 30),
                  loader(width: 90, height: 30),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  loader(width: 80, height: 20),
                  loader(width: 100, height: 30),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: loader(
                  width: MediaQuery.of(context).size.width / 2, height: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child:
                  loader(width: MediaQuery.of(context).size.width, height: 150),
            ),
          ]),
    );
  }
}
