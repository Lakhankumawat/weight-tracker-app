import 'package:flutter/material.dart';
import 'package:weight_tracker/config/size_config.dart';

Widget Header() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '74.5 Kg',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(30)),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.arrow_drop_up_outlined,
                size: 60,
                color: Colors.green,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                //padding: EdgeInsets.all(5),
                primary: Color(0xfff2f2f2),
                elevation: 0,
              ),
            )
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(8),
        ),
        Row(
          children: [
            Text(
              '-0.73kg 16%',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(15)),
            ),
            SizedBox(
              width: getProportionateScreenWidth(14),
            ),
            Text(
              'Today',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(15)),
            ),
          ],
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: getProportionateScreenHeight(8),
        ),
        Text(
          'Recent History',
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(15)),
        ),
      ],
    ),
  );
}
