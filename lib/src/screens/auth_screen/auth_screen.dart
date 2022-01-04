import 'package:flutter/material.dart';
import 'components/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = '/home-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage = 'An error occured please check your credentials!';
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    File? image,
    BuildContext ctx,
  ) async {
    UserCredential currentuser;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        currentuser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
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
      }
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      errormessage = err.toString();
      setState(() {
        _isLoading = false;
      });

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
