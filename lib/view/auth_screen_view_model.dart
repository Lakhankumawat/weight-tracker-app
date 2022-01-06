import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/provider/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthScreenViewModel extends BaseModel {
  //------------------VARIABLES-------------//
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage = 'An error occured please check your credentials!';
  String userEmail = '';
  String userName = '';
  String userPassword = '';
  var isLogin = false;
  bool showPassword = false;
  final formKey = GlobalKey<FormState>();
  File? userImgfile;

  void pickImage(File? image) {
    userImgfile = image;
  }

  changePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  changeLoginType() {
    isLogin = !isLogin;
    notifyListeners();
  }

  Future<bool> trySubmit(BuildContext context) async {
    bool _isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (userImgfile == null && !isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return false;
    }

    if (_isValid) {
      formKey.currentState!.save();
      return submitAuthForm(
        userEmail.trim(),
        userPassword.trim(),
        userName.trim(),
        isLogin,
        userImgfile,
        context,
      );
    }
    return false;
  }

  Future<bool> submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    File? image,
    BuildContext ctx,
  ) async {
    UserCredential currentuser;
    try {
      if (isLogin) {
        currentuser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        Fluttertoast.showToast(msg: 'Welcome back !');
        return true;
      } else {
        currentuser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(currentuser.user!.uid + '.jpg');

        await ref.putFile(image!);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentuser.user!.uid)
            .set({
          'name': username,
          'email': email,
          'image_url': url,
        });

        Fluttertoast.showToast(msg: 'Welcome $username!');
        return true;
      }
    } catch (err) {
      errormessage = err.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(errormessage),
          action: SnackBarAction(
            onPressed: () {},
            label: 'undo',
          ),
          backgroundColor: Colors.black,
        ),
      );
      return false;
    }
  }
}
