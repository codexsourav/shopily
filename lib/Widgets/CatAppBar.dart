import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'CartIcon.dart';

PreferredSizeWidget cartAppBar(context, {String title = ''}) {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 0,
    title: title.isNotEmpty ? Text(title) : null,
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
