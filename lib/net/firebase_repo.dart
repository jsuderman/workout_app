import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_app/net/firebase_methods.dart';

class FirebaseRepo {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();
}
