import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottamBar extends StatelessWidget {
  const BottamBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) {
          if (index == 1) {
            GoRouter.of(context).push(Uri(path: '/search').toString());
          } else if (index == 2) {
            GoRouter.of(context).push(Uri(path: '/user/myorders').toString());
          } else if (index == 3) {
            GoRouter.of(context).push(Uri(path: '/cart').toString());
          } else if (index == 4) {
            GoRouter.of(context).push(Uri(path: '/user/profile').toString());
          }
        },
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme:
            IconThemeData(color: Color.fromARGB(115, 255, 255, 255)),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Orders',
          ),
        ]);
  }
}
