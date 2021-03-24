import 'package:flutter/material.dart';
import 'package:workout_app/models/user.dart';
import 'package:workout_app/net/firebase_repo.dart';

class UserProvider with ChangeNotifier {
  AppUser _appUser;
  FirebaseRepo _firebaseRepo = FirebaseRepo();

  AppUser get getAppUser => _appUser;

  void refreshAppUser() async {
    AppUser appUser = await _firebaseRepo.getAppUserDetails();
    _appUser = appUser;
    notifyListeners();
  }
}
