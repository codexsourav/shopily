import 'package:ecomarce/Pages/CartPage.dart';
import 'package:ecomarce/Pages/HomePage.dart';
import 'package:ecomarce/Pages/OrdersProcess/Address.dart';
import 'package:ecomarce/Pages/OrdersProcess/ConfirmOrder.dart';
import 'package:ecomarce/Pages/OrdersProcess/Payment.dart';
import 'package:ecomarce/Pages/SearchPage.dart';
import 'package:ecomarce/Pages/Tabs/MyOrdersTab.dart';
import 'package:ecomarce/constents/pageName.dart';
import 'package:ecomarce/provider/auth/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ErrorPage.dart';
import '../Nointernet.dart';
import '../Pages/OrdersProcess/OrderStartus.dart';
import '../Pages/ProductPage.dart';
import '../Pages/auth/loginPage.dart';
import '../Pages/auth/sighupPage.dart';

class AppRoutes {
  static pageRoutes() {
    GoRouter routes = GoRouter(
      routes: [
        GoRoute(
          name: AppPage.home,
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: AppPage.product,
          path: '/product/:id',
          builder: (context, state) => ProductPage(id: state.params['id']),
        ),
        GoRoute(
          name: AppPage.cart,
          path: '/cart',
          builder: (context, state) => CartPage(),
        ),
        GoRoute(
          name: AppPage.search,
          path: '/search',
          builder: (context, state) => SearchPage(),
        ),
        GoRoute(
          name: AppPage.login,
          path: '/login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          name: AppPage.signup,
          path: '/signup',
          builder: (context, state) => SignupPage(),
        ),
        GoRoute(
          name: AppPage.nointernet,
          path: '/nointernet',
          builder: (context, state) => NoInternet(),
        ),
        GoRoute(
          name: AppPage.order,
          path: '/buy/orders',
          builder: (context, state) => MyOrdersTab(),
        ),
        GoRoute(
          name: AppPage.address,
          path: '/buy/address',
          builder: (context, state) => AddressPage(),
        ),
        GoRoute(
          name: AppPage.invoic,
          path: '/buy/invoic',
          builder: (context, state) => ConfirmOrder(),
        ),
        GoRoute(
          name: AppPage.payment,
          path: '/buy/payment',
          builder: (context, state) => Payment(),
        ),
        GoRoute(
          name: AppPage.orderstatus,
          path: '/buy/orderstatus',
          builder: (context, state) => OrderStatus(),
        ),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(child: ErrorPage());
      },
      redirect: (context, state) async {
        if (!await AuthProvider().chackAuth() &&
            state.location.startsWith('/buy')) {
          return context.namedLocation(AppPage.login);
        } else {
          return null;
        }
      },
    );
    return routes;
  }
}
