import 'package:flutter/material.dart';
import '../Widgets/BottamBar.dart';
import '../Widgets/MyAppbar.dart';

import 'Tabs/HomeTab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: myAppbar(context, title: 'Shopily'),
      body: HomeTab(),
      bottomNavigationBar: BottamBar(),
      drawer: Drawer(),
    );
  }
}
