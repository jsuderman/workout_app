import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/net/firebase_repo.dart';
import 'package:workout_app/ui/home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseRepo _repo = FirebaseRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginButton(),
    );
  }

  Widget loginButton() {
    return TextButton(
      onPressed: () => performLogin(),
      child: Text(
        "LOGIN",
      ),
    );
  }

  void performLogin() {
    _repo.logIn().then((User user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print("there was an error");
      }
    });
  }

  void authenticateUser(User user) {
    _repo.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _repo.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }));
      }
    });
  }
}
