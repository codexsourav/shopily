import 'package:ecomarce/provider/cart/managecart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Pages/CartPage.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartPage(),
          ));
        },
        child: Stack(
          children: [
            Icon(Icons.shopping_cart_rounded),
            Positioned(
              left: 11,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    '${context.watch<ManagecartProvider>().CartItems.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                    ),
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
