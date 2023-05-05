import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/SliderOffer.dart';
import '../../components/PopulerProducts.dart';
import '../../loading/sliderOfferLoading.dart';
import '../../provider/products/OfferProvider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChangeNotifierProvider<OfferProvider>(
            create: (_) => OfferProvider(),
            child: Consumer(
              builder: (context, OfferProvider value, child) {
                if (value.isloading) {
                  return sliderOfferLoading(context);
                } else {
                  return sliderOffer(context, data: value.offers);
                }
              },
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Populer',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 63, 63, 63)),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 141, 141, 141)),
                ),
              ],
            ),
          ),
          PopulerProduct(),
        ],
      ),
    );
  }
}
