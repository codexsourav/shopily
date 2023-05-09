import 'package:flutter/material.dart';

Widget bottamBtn({title, ontap}) {
  return Container(
    height: 80,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: GestureDetector(
      onTap: ontap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: Text(
          '$title',
          style: TextStyle(color: Colors.white),
        )),
      ),
    ),
  );
}
