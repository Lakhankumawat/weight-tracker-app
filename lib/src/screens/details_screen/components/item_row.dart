import 'package:flutter/material.dart';
import 'package:weight_tracker/src/models/weights_model.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/view/details_screen_view_model.dart';
import 'weight_operations.dart';

class ItemRow extends StatelessWidget {
  final WeightsModel weights;
  final String id;
  final DetailsScreenViewModel model;
  const ItemRow(
      {Key? key, required this.weights, required this.id, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Column(
            children: [
              Text(
                weights.value.toString(),
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                DateFormat.yMMMEd()
                    .add_jm()
                    .format(DateTime.fromMillisecondsSinceEpoch(weights.time)),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  WeightOperations.editWeight(context, model, id);
                },
                child: Icon(
                  Icons.edit,
                  size: 14,
                  color: Color(0xff05293d),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: CircleBorder(),
                  elevation: 3.0,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  WeightOperations.deleteWeight(context, model, id);
                },
                child: Icon(
                  Icons.delete_forever_rounded,
                  size: 14,
                  color: Color(0xff05293d),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: CircleBorder(),
                  elevation: 2.0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
