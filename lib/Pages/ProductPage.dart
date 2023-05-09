import 'package:ecomarce/provider/products/RatingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Widgets/CatAppBar.dart';
import '../Widgets/ProductSlider.dart';
import '../Widgets/UserReview.dart';
import '../components/PopulerProducts.dart';
import '../loading/Loder.dart';
import '../loading/productPageLoading.dart';
import '../provider/cart/managecart.dart';
import '../provider/order/orderProvider.dart';
import '../provider/products/GetAProduct.dart';

class ProductPage extends StatelessWidget {
  final id;
  const ProductPage({super.key, this.id});
  @override
  Widget build(BuildContext context) {
    final orderProc = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: cartAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChangeNotifierProvider<GetAProduct>(
              create: (_) => GetAProduct(id),
              child: Consumer(builder: (context, GetAProduct product, _) {
                if (product.isLoading) {
                  return const ProductPageLoading();
                }
                Map getdata = product.product;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ProductSlider(getdata['images']),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Consumer<ManagecartProvider>(
                                  builder: (context, value, child) {
                                    var isid = value.CartItems.where(
                                        (element) =>
                                            element['productId'] ==
                                            getdata['_id']);
                                    return IconButton(
                                      onPressed: () {
                                        value.AddRemove(getdata);
                                      },
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Icon(
                                        isid.isNotEmpty
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        size: 20,
                                        color: isid.isNotEmpty
                                            ? Color.fromARGB(255, 231, 83, 83)
                                            : Color.fromARGB(
                                                255, 216, 216, 216),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getdata['title'].toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹ ${getdata['mainprice'].toDouble()}',
                            style: const TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 121, 121, 121),
                                decoration: TextDecoration.lineThrough),
                          ),
                          RatingBar.builder(
                            initialRating: getdata['rating'].toDouble(),
                            minRating: 0.5,
                            direction: Axis.horizontal,
                            itemSize: 15,
                            ignoreGestures: true,
                            allowHalfRating: false,
                            itemCount: 5,
                            unratedColor:
                                const Color.fromARGB(255, 226, 226, 226),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rate) {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹ ${getdata['price'].toDouble()}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: getdata['public']
                                ? () {
                                    orderProc
                                        .setOrderType(iscart: false, product: [
                                      {
                                        "productId": getdata['_id'],
                                        "quantity": 1,
                                        "product": getdata,
                                      }
                                    ]);
                                    GoRouter.of(context).push(
                                        Uri(path: '/user/address').toString());
                                  }
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Text(
                                getdata['public'] ? 'BUY NOW' : "Coming Soon",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 238, 238),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            'Free Delivery',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 124, 124, 124)),
                          )),
                    ),
                    // about the product
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'About The Product',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 63, 63, 63)),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            getdata['desc'].toString(),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            ChangeNotifierProvider<RatingProvider>(
                create: (_) => RatingProvider(id),
                child: Consumer(
                  builder: (context, RatingProvider value, child) {
                    if (value.isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: loader(
                            height: 80,
                            width: MediaQuery.of(context).size.width),
                      );
                    } else if (value.ratings.isEmpty) {
                      return const SizedBox();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Product Reviews',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 63, 63, 63)),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.ratings.length,
                          itemBuilder: (context, index) {
                            // return Text('hello');
                            return userReview(value.ratings[index]);
                          },
                        )
                      ],
                    );
                  },
                )),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Recomnaded For You',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
            ),
            const PopulerProduct(),
          ],
        ),
      ),
    );
  }
}
