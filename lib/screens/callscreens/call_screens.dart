import 'package:flutter/material.dart';
import 'package:workout_app/models/call.dart';
import 'package:workout_app/resources/call_methods.dart';

class CallScreen extends StatefulWidget {
  CallScreen({Key key, Call call}) : super(key: key);
  final Call call;

  CallScreen({
    @required this.call,
  });

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "call has been made",
          ),
          MaterialButton(
            color: Colors.red,
            child: Icon(
              Icons.call_end,
              color: Colors.white,
            ),
            onPressed: () {
              CallMethods.endCall(call: widget.call);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
