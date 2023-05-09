import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomarce/constents/pageName.dart';
import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../Widgets/MyAppbar.dart';

class MyOrdersTab extends StatefulWidget {
  const MyOrdersTab({super.key});

  @override
  State<MyOrdersTab> createState() => _MyOrdersTabState();
}

class _MyOrdersTabState extends State<MyOrdersTab> {
  bool loading = false;
  var orderdata = [];
  getOrders() async {
    setState(() {
      loading = true;
    });
    var data = await ApiHelper.callapi(path: "/order");
    setState(() {
      orderdata = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, title: 'Orders'),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : orderdata.isEmpty
              ? const Center(child: Text('No Orders Found!'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: orderdata.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            onTap: () {
                              context.pushNamed(AppPage.order,
                                  extra: orderdata[index]);
                            },
                            leading: CachedNetworkImage(
                              imageUrl: orderdata[index]['product']['poster'],
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
                                        color:
                                            Color.fromARGB(255, 243, 243, 243)),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                            title: Text(
                              orderdata[index]['product']['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                orderdata[index]['status'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: orderdata[index]['status'] ==
                                            'delivered'
                                        ? Colors.green
                                        : orderdata[index]['status'] == 'cancel'
                                            ? Colors.red
                                            : null),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
