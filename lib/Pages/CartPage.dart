import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Widgets/CartIcon.dart';
import '../Widgets/CartProduct.dart';
import '../provider/cart/managecart.dart';
import '../provider/order/orderProvider.dart';
import 'SearchPage.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProc = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Cart'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchPage(),
              ));
            },
            icon: Icon(Icons.search),
          ),
          CartIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Your Cart',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 63, 63, 63)),
                ),
              ),
              SizedBox(height: 8),
              Consumer<ManagecartProvider>(builder: (context, value, child) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.CartItems.length,
                  itemBuilder: (context, index) {
                    return CartProduct(
                      data: value.CartItems[index],
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL PRICE',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '₹ ${context.watch<ManagecartProvider>().totalPrice}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(226, 243, 243, 243)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: context.read<ManagecartProvider>().CartItems.isEmpty
                    ? null
                    : () {
                        orderProc.setOrderType(
                            iscart: true,
                            product:
                                context.read<ManagecartProvider>().CartItems);
                        GoRouter.of(context)
                            .push(Uri(path: '/user/address').toString());
                      },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Text(
                    'BUY NOW',
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
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
