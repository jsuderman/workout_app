import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/blocs/auth_bloc.dart';
import 'package:workout_app/screens/pageviews/chat_list_screen.dart';
import 'package:workout_app/ui/authentication.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<User> loginStateSubscription;

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Authentication(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
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
    final authBloc = Provider.of<AuthBloc>(context);
    var onPageChanged;
    return Scaffold(
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
          SignInButton(
            Buttons.Google,
            text: "Sign out",
            onPressed: () => authBloc.logout(),
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
    );
  }
}
