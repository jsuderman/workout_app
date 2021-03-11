import 'package:flutter/material.dart';
import 'package:workout_app/net/firebase_repo.dart';

class ChatListScreen extends StatefulWidget {
  ChatListScreen({Key key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

//global var
final FirebaseRepo _repository = FirebaseRepo();

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
      });
    });
  }

  CustomAppBar customAppBar(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(context),
    );
  }
}
