import 'package:flutter/material.dart';

Widget formInputBox(
    {controller,
    hint,
    keybordtype = TextInputType.text,
    validate,
    obscureText = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            hint.toString(),
            style: TextStyle(
              color: Color.fromARGB(255, 70, 70, 70),
              fontSize: 14,
            ),
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          keyboardType: keybordtype,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 247, 247, 247),
            border: InputBorder.none,
          ),
          validator: validate,
        ),
      ],
    ),
  );
}
