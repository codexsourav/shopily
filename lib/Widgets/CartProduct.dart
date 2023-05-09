import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:ecomarce/provider/cart/managecart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CartProduct extends StatelessWidget {
  final data;
  const CartProduct({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Color.fromARGB(181, 244, 67, 54)),
        direction: DismissDirection.endToStart,
        secondaryBackground: Container(
          color: Colors.red,
          padding: EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        onDismissed: (direction) async {
          await context.read<ManagecartProvider>().AddRemove(data['product']);
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CachedNetworkImage(
                      imageUrl: data['product']['poster'].toString(),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width - 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['product']['title'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '₹ ${data['product']['price'].toString()}',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Quantity',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomDropdownButton2(
                      buttonWidth: 65,
                      dropdownWidth: 65,
                      buttonHeight: 30,
                      hint: data['quantity'].toString(),
                      dropdownItems: ['1', '2', '3'],
                      value: data['quantity'].toString(),
                      onChanged: (value) {
                        context
                            .read<ManagecartProvider>()
                            .updateCart(id: data['productId'], quantity: value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
