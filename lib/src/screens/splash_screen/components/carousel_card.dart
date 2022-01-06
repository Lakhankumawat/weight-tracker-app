import 'package:flutter/material.dart';
import 'package:weight_tracker/config/size_config.dart';

Widget CarouselCard(BuildContext context, Map<String, String> carouselDetails) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    carouselDetails['image'] as String,
                    height: getProportionateScreenHeight(95),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(8),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carouselDetails['text'] as String,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                    ),
                    Text(
                      carouselDetails['author'] as String,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
