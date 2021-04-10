import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';
import 'package:workout_app/provider/user_provider.dart';
import 'package:workout_app/screens/callscreens/pickup/pickup_layout.dart';
import 'package:workout_app/screens/pageviews/chat_list_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int _page = 0;

  UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshAppUser();
    });

    _pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        body: PageView(
          children: <Widget>[
            Container(
              child: ChatListScreen(),
            ),
            Center(
              child: Text("Workouts"),
            ),
            Center(
              child: Text("Tracker"),
            ),
          ],
          controller: _pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: CupertinoTabBar(
              backgroundColor: Colors.black,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat,
                      color: (_page == 0) ? Colors.lightBlue : Colors.grey),
                  label: ("chat"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center,
                      color: (_page == 1) ? Colors.lightBlue : Colors.grey),
                  label: ("workouts"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment,
                      color: (_page == 2) ? Colors.lightBlue : Colors.grey),
                  label: ("tracker"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.exit_to_app,
                      color: (_page == 3) ? Colors.lightBlue : Colors.grey),
                  label: ("sign out"),
                ),
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          ),
        ),
      ),
    );
  }
}
