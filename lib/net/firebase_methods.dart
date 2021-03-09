import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods {
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  

  Future<User> getCurrentUser() async {}
    User currentUser;
    currentUser = await _auth.authStateChanges();
    return currentUser;
  }


