import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/constants/strings.dart';
import 'package:workout_app/models/message.dart';
import 'package:workout_app/models/user.dart';
import 'package:workout_app/utils/utils.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firebasefirestore.collection(USERS_COLLECTION);

  static final FirebaseFirestore _firebasefirestore =
      FirebaseFirestore.instance;

  AppUser appUser = AppUser();

  Future<User> getCurrentAppUser() async {
    User currentAppUser;
    currentAppUser = _auth.currentUser;
    return currentAppUser;
  }

  Future<AppUser> getAppUserDetails() async {
    User currentUser = await getCurrentAppUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();

    return AppUser.fromMap(documentSnapshot.data());
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
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
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
        .collection(USERS_COLLECTION)
        .doc(currentUser.uid)
        .set(appUser.toMap(appUser));
  }

  Future<List<AppUser>> fetchAllUsers(User currentUser) async {
    List<AppUser> userList = List<AppUser>.empty(growable: true);

    QuerySnapshot querySnapshot =
        await firebasefirestore.collection(USERS_COLLECTION).get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(AppUser.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }

  Future<void> addMessageToDb(
      Message message, AppUser sender, AppUser reciever) async {
    var map = message.toMap();

    await firebasefirestore
        .collection(MESSAGES_COLLECTION)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await firebasefirestore
        .collection(MESSAGES_COLLECTION)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }
}
