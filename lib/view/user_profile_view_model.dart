import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/provider/base_model.dart';

class UserProfileViewModel extends BaseModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  init() {
    String? uid = auth.currentUser?.uid;
    var data = db.collection('users').doc(uid).get();
  }
}
