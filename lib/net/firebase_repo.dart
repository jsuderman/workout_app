import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_app/net/firebase_methods.dart';

class FirebaseRepo {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentAppUser() => _firebaseMethods.getCurrentAppUser();

  Future<User> logIn() => _firebaseMethods.logIn();

  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

  getCurrentUser() {}
}
