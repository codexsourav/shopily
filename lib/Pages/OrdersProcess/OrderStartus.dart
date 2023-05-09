import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomarce/Widgets/CatAppBar.dart';
import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Widgets/fileds/bottamNavBtn.dart';

class OrderStatus extends StatefulWidget {
  final data;
  const OrderStatus({super.key, required this.data});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  var status = '';
  bool loading = false;
  cancelOrder() async {
    // cancel
    setState(() {
      loading = true;
    });
    var data = await ApiHelper.callapi(
        path: '/order/' + widget.data['_id'] + "/cancel", method: "POST");
    if (data['success'] == true) {
      setState(() {
        status = "cancel";
      });
    }
    setState(() {
      loading = false;
    });
  }

  rateTheProduct() {}

  @override
  void initState() {
    super.initState();
    setState(() {
      status = widget.data['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: cartAppBar(context, title: "My Orders"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Card(
                elevation: 0, // Controls the card's shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Rounded corners for the card
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: CachedNetworkImage(
                          imageUrl: widget.data['product']['poster'],
                          fit: BoxFit.cover,
                          height: 90,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['product']['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: status == 'delivered'
                                  ? Colors.green
                                  : status == 'cancel'
                                      ? Colors.red
                                      : const Color.fromARGB(255, 223, 200, 0),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Quantity: ${widget.data['quantity']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Price: ${widget.data['buyPrice'] * widget.data['quantity']} RS",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.data['address']['name'],
                                ),
                                Text(widget.data['address']['mobile']
                                    .toString()),
                                Text(
                                    "${widget.data['address']['addr1']} ${widget.data['address']['addr2']}"),
                                Text(
                                    "${widget.data['address']['city']} ${widget.data['address']['state']}"),
                                Text(widget.data['address']['pincode']
                                    .toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: status == "cancel"
          ? null
          : bottamBtn(
              title: loading
                  ? "Loading..."
                  : (status == "delivered" ? "Rate Product" : 'CANCEL ORDER'),
              ontap: loading
                  ? null
                  : status == "delivered"
                      ? rateTheProduct
                      : cancelOrder,
            ),
    );
  }
}
