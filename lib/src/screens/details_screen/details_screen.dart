import 'package:flutter/material.dart';
import 'package:weight_tracker/provider/base_view.dart';
import 'package:weight_tracker/view/details_screen_view_model.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = '/details-screen';
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailsScreenViewModel>(
        onModelReady: (model) => {},
        builder: (context, model, child) {
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Body(
              model: model,
            ),
          );
        });
  }
}
