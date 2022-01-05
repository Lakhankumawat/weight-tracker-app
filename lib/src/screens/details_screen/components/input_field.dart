import 'package:flutter/material.dart';
import 'package:weight_tracker/view/details_screen_view_model.dart';

Widget inputField(BuildContext context, TextEditingController controller) {
  return TextFormField(
    controller: controller,
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
