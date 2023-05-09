import 'package:ecomarce/constents/pageName.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Page Not Found",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacementNamed(AppPage.home);
                },
                child: const Text("Back To Home"))
          ],
        ),
      ),
    );
  }
}
