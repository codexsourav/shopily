import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Widgets/MyAppbar.dart';
import '../../Widgets/fileds/bottamNavBtn.dart';

class Payment extends StatelessWidget {
  Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, title: 'Payment'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'Select Payment Option',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text(
                'Bank Transfer',
                style: TextStyle(color: Color.fromARGB(255, 134, 134, 134)),
              ),
              subtitle: Text(
                'Coming soon',
                style: TextStyle(
                  color: Color.fromARGB(255, 134, 134, 134),
                  fontSize: 10,
                ),
              ),
              leading: Radio(
                value: 'bank',
                groupValue: '1',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('Upi Payment',
                  style: TextStyle(color: Color.fromARGB(255, 151, 151, 151))),
              subtitle: Text(
                'Coming soon',
                style: TextStyle(
                  color: Color.fromARGB(255, 134, 134, 134),
                  fontSize: 10,
                ),
              ),
              leading: Radio(
                value: 'upi',
                groupValue: '1',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('Cash On Delevery'),
              leading: Radio(
                value: 'cod',
                groupValue: 'cod',
                activeColor: Colors.black,
                onChanged: (value) {},
              ),
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: bottamBtn(title: 'Place Order'),
    );
  }

  TextStyle infoTextStyle = TextStyle(fontWeight: FontWeight.bold);
}
