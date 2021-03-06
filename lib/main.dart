import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/blocs/auth_bloc.dart';
import 'package:workout_app/net/firebase_repo.dart';
import 'package:workout_app/ui/authentication.dart';
import 'package:workout_app/ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseRepo _repo = FirebaseRepo();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: FutureBuilder(
          future: _repo.getCurrentAppUser(),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return Authentication();
            }
          },
        ),
      ),
    );
  }
}
