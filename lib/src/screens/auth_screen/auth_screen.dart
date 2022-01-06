import 'package:flutter/material.dart';
import 'package:weight_tracker/config/size_config.dart';
import 'package:weight_tracker/provider/base_view.dart';
import 'package:weight_tracker/view/auth_screen_view_model.dart';
import 'components/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthScreenViewModel>(builder: (context, model, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image.asset(
                'assets/images/splash_1024.png',
                height: getProportionateScreenHeight(65),
                width: getProportionateScreenWidth(63),
              ),
            ),
            Text(
              'Hello',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(40),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                Text(
                  'Welcome to Lossy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            AuthForm(
              model: model,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'By tapping SignUp I agree to Lossy\'s Terms of service.Privacy Policy and User Agreement. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: getProportionateScreenWidth(13),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
