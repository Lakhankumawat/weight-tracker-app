import 'package:flutter/material.dart';
import 'image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.setValues,
    this.isLoading,
  );
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    File? imageFile,
    BuildContext ctx,
  ) setValues;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  var _isLogin = false;
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  File? _userImgfile;
  void _pickImage(File? image) {
    _userImgfile = image;
  }

  void _trySubmit() {
    bool _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImgfile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (_isValid) {
      _formKey.currentState!.save();
      widget.setValues(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        _userImgfile as File,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) PickImage(_pickImage),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onSaved: (value) {
                      _userEmail = value as String;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.length <= 3) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'UserName',
                      ),
                      onSaved: (value) {
                        _userName = value as String;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be atleast 7 characters';
                      }
                      return null;
                    },
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                    onSaved: (value) {
                      _userPassword = value as String;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.isLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(
                        _isLogin ? 'Login' : 'Signup',
                      ),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create New Account'
                            : 'I already have an account',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
