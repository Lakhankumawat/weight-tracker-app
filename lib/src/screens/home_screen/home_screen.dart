import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/src/screens/details_screen/details_screen.dart';
import 'components/body.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'components/custom_dialog_box.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void addWeight(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
            title: 'Add new weight',
            descriptions: 'Lose weight & keep fit',
            image: "assets/images/giphy.gif",
            press1: () async {
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Weight added successfully");
            },
            press2: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(LineChartSample2.routeName);
            },
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //
      //
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Tracker'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          addWeight(context);
        },
        child: Text('Add Weight'),
        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.black,
      //   onTap: _onItemTapped,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       title: Text('Home'),
      //       icon: Icon(Icons.home),
      //       backgroundColor: Colors.lightBlue,
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('Statistics'),
      //       icon: Icon(Icons.auto_graph_rounded),
      //       backgroundColor: Colors.lightBlue,
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('History'),
      //       icon: Icon(Icons.history),
      //       backgroundColor: Colors.lightBlue,
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('Settings'),
      //       icon: Icon(Icons.settings),
      //       backgroundColor: Colors.lightBlue,
      //     ),
      //   ],
      // ),
    );
  }
}
