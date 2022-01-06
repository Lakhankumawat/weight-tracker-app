import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weight_tracker/view/details_screen_view_model.dart';
import 'package:weight_tracker/view/home_screen_view_model.dart';
import 'custom_dialog_box.dart';

class WeightOperations {
  static void addWeight(BuildContext context, HomeScreenViewModel model) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
            title: 'Add new weight',
            descriptions: 'Lose weight & keep fit',
            image: "assets/images/add.png",
            controller: model.addweightController,
            buttonText: 'Add',
            press1: () async {
              model.save();
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Weight added successfully");
            },
          );
        });
  }

  static void editWeight(
      BuildContext context, DetailsScreenViewModel model, String docId) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
            title: 'Edit weight',
            descriptions: 'Lose weight & keep fit',
            image: "assets/images/edit.png",
            controller: model.editweightController,
            buttonText: 'Save',
            press1: () async {
              model.edit(docId: docId);
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Weight saved");
            },
          );
        });
  }

  static void deleteWeight(
      BuildContext context, DetailsScreenViewModel model, String docId) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
            title: 'Delete weight?',
            descriptions: 'This entry will be permanently deleted!',
            image: "assets/images/delete.png",
            buttonText: 'Delete',
            press1: () async {
              model.delete(docId: docId);
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Weight deleted");
            },
            press2: () {
              Navigator.of(context).pop();
            },
          );
        });
  }
}
