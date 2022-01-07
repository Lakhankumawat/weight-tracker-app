import 'package:flutter/material.dart';
import 'package:weight_tracker/config/size_config.dart';
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
    int change = int.parse(weights.value) - 74;
    final bool goodWeight = model.checkWeight(int.parse(weights.value));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: getProportionateScreenHeight(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Icon(
                goodWeight
                    ? Icons.arrow_downward_outlined
                    : Icons.arrow_upward_outlined,
                size: 20,
                color: goodWeight ? Colors.green : Colors.red,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weights.value.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    DateFormat.MMMEd().add_jm().format(
                        DateTime.fromMillisecondsSinceEpoch(weights.time)),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                goodWeight ? change.toString() : '+$change',
                style: TextStyle(
                    color: goodWeight ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(15)),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      WeightOperations.editWeight(context, model, id);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      //color: Color(0xff05293d),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      elevation: 0,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      WeightOperations.deleteWeight(context, model, id);
                    },
                    child: Icon(
                      Icons.delete_forever_rounded,
                      size: 22,
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.grey,
                      shape: CircleBorder(),
                      elevation: 0,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
