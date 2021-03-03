import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    //TODO implement initstate
    super.initState();
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
    var onPageChanged;
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Center(
            child: Text("Chat"),
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
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }
}
