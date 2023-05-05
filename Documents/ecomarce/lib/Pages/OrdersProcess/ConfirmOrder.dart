import 'package:flutter/material.dart';

import '../../Widgets/MyAppbar.dart';
import '../../Widgets/fileds/bottamNavBtn.dart';
import 'Payment.dart';

class ConfirmOrder extends StatelessWidget {
  ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar(context, title: 'Order Info'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.asset('assets/products/product-3.png'),
                        title: Text(
                          'boar 120g Wheard Head Phone',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text('₹ 5000.00'),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text('1 Pc'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(children: [
                    ListTile(
                      title: Text(
                        'Subtotal',
                        style: infoTextStyle,
                      ),
                      trailing: Text(
                        '₹ 5000.00',
                        style: infoTextStyle,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Discount',
                        style: infoTextStyle,
                      ),
                      trailing: Text(
                        '₹ 5000.00',
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
                        '5000.00 RS',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: bottamBtn(
            title: 'Make Payment',
            ontap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Payment(),
              ));
            }));
  }

  TextStyle infoTextStyle = TextStyle(fontWeight: FontWeight.bold);
}
