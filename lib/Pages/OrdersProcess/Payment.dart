import 'package:cool_alert/cool_alert.dart';
import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Widgets/MyAppbar.dart';
import '../../Widgets/PriceBox.dart';
import '../../Widgets/fileds/bottamNavBtn.dart';
import '../../provider/order/orderProvider.dart';

class Payment extends StatefulWidget {
  Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool loading = false;
  palceOrder() async {
    setState(() {
      loading = true;
    });
    final orderInfo = Provider.of<OrderProvider>(context, listen: false);
    for (var i = 0; i < orderInfo.product.length; i++) {
      var data = await ApiHelper.callapi(
          method: "POST",
          path:
              "/order/new/${orderInfo.product[i]['productId']}/${orderInfo.product[i]['quantity']}");
    }
    setState(() {
      loading = false;
    });
    await CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: "Congratulations",
        text: "Your Order Is Placed",
        confirmBtnText: "Back To Home",
        onConfirmBtnTap: () {
          GoRouter.of(context).push(Uri(path: '/').toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    final orderInfo = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: myAppbar(context, title: 'Payment'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
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
              subtitle: const Text(
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
              subtitle: const Text(
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
            const SizedBox(height: 20),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
          title: loading ? "Loading..." : 'Place Order',
          ontap: loading ? null : palceOrder),
    );
  }

  TextStyle infoTextStyle = const TextStyle(fontWeight: FontWeight.bold);
}
