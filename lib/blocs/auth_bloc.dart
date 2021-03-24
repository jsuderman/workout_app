import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/net/auth_services.dart';

class AuthBloc with ChangeNotifier {
  final authService = AuthServices();
  final googleSignIn = GoogleSignIn(scopes: ['email']);

  Stream<User> get currentUser => authService.currentUser;

  loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      //Firebase sign in
      final result = await authService.signInWithCredential(credential);

      print('${result.user.displayName}');
    } catch (e) {
      print(e);
    }
  }

  logout() {
    authService.logout();
  }
}
