import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/provider/base_model.dart';

class DetailsScreenViewModel extends BaseModel {
  //-------------VARIABLES-------------//
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController editweightController = TextEditingController();

  ///Updating existing value to sub-collection:
  void edit({required String docId}) {
    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      FirebaseFirestore.instance
          .collection('weights')
          .doc(uid)
          .collection('userWeights')
          .doc(docId)
          .update({'value': editweightController.text});
    }
    editweightController.clear();
  }

  ///Deleting sub-collection:
  void delete({required String docId}) {
    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      FirebaseFirestore.instance
          .collection('weights')
          .doc(uid)
          .collection('userWeights')
          .doc(docId)
          .delete();
    }
  }

  bool checkWeight(int value) {
    if (value < 74) {
      return true;
    } else
      return false;
  }
}
