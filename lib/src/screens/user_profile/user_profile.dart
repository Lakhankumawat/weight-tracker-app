import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weight_tracker/provider/base_view.dart';
import 'package:weight_tracker/src/screens/about_screen/about_us_screen.dart';
import 'package:weight_tracker/src/screens/auth_screen/auth_screen.dart';
import 'package:weight_tracker/view/user_profile_view_model.dart';

class UserProfile extends StatelessWidget {
  final ThemeMode? themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;
  final FlexSchemeData? flexSchemeData;

  const UserProfile(
      {Key? key, this.onThemeModeChanged, this.themeMode, this.flexSchemeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UserProfileViewModel>(
        onModelReady: (model) => {
              model.init(context),
            },
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: model.isLoaded
                  ? ListView(
                      children: [
                        // User card
                        BigUserCard(
                          cardColor: Theme.of(context).primaryColor,
                          userName: model.user.name,
                          userProfilePic: NetworkImage(model.user.imageUrl),
                          cardActionWidget: SettingsItem(
                            icons: Icons.edit,
                            iconStyle: IconStyle(
                              withBackground: true,
                              borderRadius: 50,
                              backgroundColor: Colors.yellow[600],
                            ),
                            title: "Modify",
                            subtitle: "Tap to change your data",
                            onTap: () {
                              Fluttertoast.showToast(msg: 'Coming soon!');
                            },
                          ),
                        ),
                        SettingsGroup(
                          items: [
                            SettingsItem(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: 'Coming soon! stay updated');
                              },
                              icons: CupertinoIcons.pencil_outline,
                              iconStyle: IconStyle(),
                              title: 'Appearance',
                              subtitle: "Make Weight Tracker'App yours",
                            ),
                            SettingsItem(
                              onTap: () {
                                // if (model.isDark) {
                                //   onThemeModeChanged!(ThemeMode.light);
                                // } else {
                                //   onThemeModeChanged!(ThemeMode.dark);
                                // }
                              },
                              icons: Icons.dark_mode_rounded,
                              iconStyle: IconStyle(
                                iconsColor: Colors.white,
                                withBackground: true,
                                backgroundColor: Colors.red,
                              ),
                              title: 'Dark mode',
                              subtitle: "Automatic",
                              trailing: Switch.adaptive(
                                  value: false, onChanged: (value) {}),
                            ),
                          ],
                        ),
                        SettingsGroup(
                          items: [
                            SettingsItem(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AboutUs.routeName);
                              },
                              icons: Icons.info_rounded,
                              iconStyle: IconStyle(
                                backgroundColor: Colors.purple,
                              ),
                              title: 'About',
                              subtitle: "Learn more about Devs",
                            ),
                          ],
                        ),
                        // You can add a settings title
                        SettingsGroup(
                          settingsGroupTitle: "Account",
                          items: [
                            SettingsItem(
                              onTap: () {
                                model.signOut();
                                Fluttertoast.showToast(msg: 'Signout Success');
                                Navigator.of(context)
                                    .pushNamed(AuthScreen.routeName);
                              },
                              icons: Icons.exit_to_app_rounded,
                              title: "Sign Out",
                            ),
                            SettingsItem(
                              onTap: () {
                                model.deleteAccount();
                                Fluttertoast.showToast(
                                    msg: 'User Account Deleted');
                                Navigator.of(context)
                                    .pushNamed(AuthScreen.routeName);
                              },
                              icons: CupertinoIcons.delete_solid,
                              title: "Delete account",
                              titleStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        FlexThemeModeSwitch(
                          themeMode: themeMode as ThemeMode,
                          onThemeModeChanged:
                              onThemeModeChanged as void Function(ThemeMode),
                          flexSchemeData: flexSchemeData as FlexSchemeData,
                          buttonOrder: FlexThemeModeButtonOrder.lightSystemDark,
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        });
  }
}
