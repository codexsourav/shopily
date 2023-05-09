import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomarce/provider/order/orderProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../Widgets/MyAppbar.dart';
import '../../Widgets/PriceBox.dart';
import '../../Widgets/fileds/bottamNavBtn.dart';
import '../../constents/pageName.dart';
import 'Payment.dart';

class ConfirmOrder extends StatelessWidget {
  ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final orderInfo = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: myAppbar(context, title: 'Order Info'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderInfo.product.length,
                itemBuilder: (context, index) {
                  var data = orderInfo.product[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: data['product']['poster'],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 250, 250, 250),
                              highlightColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 243, 243, 243)),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                        title: Text(
                          data['product']['title'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                              '₹ ${data['product']['price'] * data['quantity']}'),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text('${data['quantity']} Pc'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      orderInfo.address['name'],
                    ),
                    Text(orderInfo.address['mobile'].toString()),
                    Text(
                        "${orderInfo.address['addr1']} ${orderInfo.address['addr2']}"),
                    Text(
                        "${orderInfo.address['city']} ${orderInfo.address['state']}"),
                    Text(orderInfo.address['pincode'].toString()),
                  ],
                ),
              ),
              const PriceBox(),
            ],
          ),
        ),
        bottomNavigationBar: bottamBtn(
            title: 'Make Payment',
            ontap: () {
              context.pushNamed(AppPage.payment);
            }));
  }
}
