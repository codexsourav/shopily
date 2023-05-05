import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'CartIcon.dart';

PreferredSizeWidget cartAppBar(context) {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {
          GoRouter.of(context).push(Uri(path: '/search').toString());
        },
        icon: Icon(Icons.search),
      ),
      CartIcon(),
    ],
  );
}
