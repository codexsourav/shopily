import 'package:flutter/material.dart';
import '../../Widgets/MyAppbar.dart';

class MyOrdersTab extends StatelessWidget {
  MyOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, title: 'Orders'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'My Orders',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 63, 63, 63)),
                ),
              ),
              SizedBox(height: 8),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8),
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
                    child: Text('Shiping Tomorow'),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
