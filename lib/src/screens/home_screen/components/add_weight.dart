import 'package:flutter/material.dart';

Widget addWeight(BuildContext context) {
  return TextFormField(
    validator: (value) {
      if (value == null) {
        return 'Please enter a valid value';
      }
      return null;
    },
    keyboardType: TextInputType.number,
    textAlign: TextAlign.center,
    maxLines: 1,
    decoration: InputDecoration(
      hintText: 'Enter weight',
    ),
    onSaved: (value) {
      print(value);
    },
  );
}
