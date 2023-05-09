import 'package:ecomarce/provider/order/orderProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart/managecart.dart';

class PriceBox extends StatelessWidget {
  const PriceBox({super.key});

  @override
  Widget build(BuildContext context) {
    final orderinfo = Provider.of<OrderProvider>(context);

    TextStyle infoTextStyle = TextStyle(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Builder(builder: (context) {
          bool iscart = orderinfo.iscart;
          var totalPrice = iscart
              ? context.watch<ManagecartProvider>().totalPrice
              : orderinfo.product[0]['product']['price'].toDouble();
          return Column(children: [
            ListTile(
              title: Text(
                'Subtotal',
                style: infoTextStyle,
              ),
              trailing: Text(
                '₹ ${totalPrice} RS',
                style: infoTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Delevety Fee',
                style: infoTextStyle,
              ),
              trailing: Text(
                'Free',
                style: infoTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Total',
                style: infoTextStyle,
              ),
              trailing: Text(
                "${totalPrice} RS",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )
          ]);
        }),
      ),
    );
  }
}
