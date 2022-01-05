import 'package:flutter/material.dart';
import 'package:weight_tracker/config/size_config.dart';
import 'package:weight_tracker/provider/base_view.dart';
import 'package:weight_tracker/src/screens/details_screen/components/weight_operations.dart';
import 'package:weight_tracker/src/screens/details_screen/details_screen.dart';
import 'package:weight_tracker/src/widgets/custom_bottom_nav_bar.dart';
import 'package:weight_tracker/src/screens/user_profile/user_profile.dart';
import 'components/body.dart';
import 'package:weight_tracker/view/home_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView<HomeScreenViewModel>(
        onModelReady: (model) => {},
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Lossy')),
            ),
            body: PageView(controller: model.pageController, children: [
              SingleChildScrollView(
                child: Body(
                  model: model,
                ),
              ),
              DetailsScreen(),
              UserProfile(),
            ]),
            floatingActionButton: ElevatedButton(
              onPressed: () {
                WeightOperations.addWeight(context, model);
              },
              child: Text(
                'Add Weight',
                style: TextStyle(
                  fontSize: 15,
                  color: ThemeData().scaffoldBackgroundColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.all(10),
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(model),
          );
        });
  }
}
