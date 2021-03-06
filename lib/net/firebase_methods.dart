import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/models/user.dart';
import 'package:workout_app/utils/utils.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

  AppUser appUser = AppUser();

  Future<User> getCurrentAppUser() async {
    User currentAppUser;
    currentAppUser = _auth.currentUser;
    return currentAppUser;
  }

  Future<User> logIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _signInAuthentication.accessToken,
        idToken: _signInAuthentication.idToken);

    User user = (await _auth.signInWithCredential(credential)) as User;
    return user;
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    String username = Utils.getUserName(currentUser.email);

    appUser = AppUser(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: username);

    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .set(appUser.toMap(appUser));
  }
}
