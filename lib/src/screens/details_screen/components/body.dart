import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/src/models/weights_model.dart';
import 'package:weight_tracker/view/details_screen_view_model.dart';
import 'item_row.dart';

class Body extends StatelessWidget {
  final DetailsScreenViewModel model;
  const Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('weights')
            .doc(model.auth.currentUser!.uid)
            .collection('userWeights')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final size = orderSnapshot.data!.docs.length;
            if (size != 0) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: size,
                itemBuilder: (context, index) {
                  DocumentSnapshot orderData = orderSnapshot.data!.docs[index];
                  String docId = orderData.id;
                  WeightsModel weights = weightsModelFromJson(
                      orderData.data() as Map<String, dynamic>);
                  return ItemRow(
                    weights: weights,
                    id: docId,
                    model: model,
                  );
                },
              );
            } else
              return Text('No Weights added , add some now ');
          }
        });
  }
}
