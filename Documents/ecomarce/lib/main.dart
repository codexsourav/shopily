import 'package:ecomarce/provider/auth/AuthProvider.dart';
import 'package:ecomarce/provider/cart/managecart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/router.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ChangeNotifierProvider<ManagecartProvider>(
          create: (_) => ManagecartProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: "Shopily",
        debugShowCheckedModeBanner: false,
        routeInformationProvider:
            AppRoutes.pageRoutes().routeInformationProvider,
        routeInformationParser: AppRoutes.pageRoutes().routeInformationParser,
        routerDelegate: AppRoutes.pageRoutes().routerDelegate);
  }
}
