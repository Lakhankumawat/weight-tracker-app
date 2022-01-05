import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:weight_tracker/provider/base_model.dart';

class HomeScreenViewModel extends BaseModel {
  //-------------VARIABLES-------------//
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController addweightController = TextEditingController();
  int selectedIndex = 0;
  final PageController pageController = PageController();

  ///On tapping bottom nav bar items
  void onItemTapped(int index) {
    selectedIndex = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    notifyListeners();
  }

  ///Adding new value to sub-collection:
  void save() {
    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      db.collection('weights').doc(uid).collection("userWeights").add({
        'value': addweightController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
        'docId': db
            .collection('weights')
            .doc(uid)
            .collection("userWeights")
            .doc()
            .id,
      });
    }
    addweightController.clear();
  }
}
