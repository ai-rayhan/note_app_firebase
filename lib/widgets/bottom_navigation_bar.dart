import 'package:flutter/material.dart';
import 'package:note_app_firebase/screens/account_screen.dart';

import '../screens/news_screen.dart';
import '../screens/tasks_screen.dart';



class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => MyBottomNavBarState();
}

class MyBottomNavBarState extends State<MyBottomNavBar> {
  static int bottomNavigationTabIndex = 0;
  static void selectPage(BuildContext context, int index) {
    MyBottomNavBarState? stateObject =
        context.findAncestorStateOfType<MyBottomNavBarState>();
    stateObject?.setState(() {
      bottomNavigationTabIndex = index;
    });
    print("called nav");
  }

  static void refresh(BuildContext context) {
    MyBottomNavBarState? stateObject =
        context.findAncestorStateOfType<MyBottomNavBarState>();
    stateObject?.setState(() {
      bottomNavigationTabIndex = 0;
      bottomNavigationTabIndex = 1;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    // CustomNavigationDrawer(),
    TaskScreen(),
    NewsScreen(),
    AccountScreen(),

  ];

  //Implementing Bottom Navigation Bar

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(bottomNavigationTabIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.verified,
                ),
                icon: Icon(Icons.verified_outlined),
                label: "Task",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.newspaper),
                icon: Icon(Icons.newspaper_outlined),
                label: "News",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.account_circle),
                icon: Icon(Icons.account_circle_outlined),
                label: "My App",
              ),
              
            ],
            currentIndex: bottomNavigationTabIndex,
            onTap: (int index) {
              setState(() {
                bottomNavigationTabIndex = index;
              });
            }),
      ),
    );
  }
}
