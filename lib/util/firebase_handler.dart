import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gest_loc/util/constant.dart';

class FirebaseHandler {

  final authInstance = FirebaseAuth.instance;

  Future<User?> signIn(String mail, String password) async {
    final userCredential = await authInstance.signInWithEmailAndPassword(email: mail, password: password);
    final User? user = userCredential.user;
    return user;
  }

  Future<User?> createUser(String mail, String password, String name, String firstName) async {
    final userCredential = await authInstance.createUserWithEmailAndPassword(email: mail, password: password);
    final User? user = userCredential.user;
    if(user != null) {
      Map<String, dynamic> memberMap = {
        nameKey: name,
        firstNameKey: firstName,
        uidKey: user.uid,
        mailKey: mail,
      };
      addUserToFirebase(memberMap);
    }
    return user;
  }

  //Database
  static final firestoreInstance = FirebaseFirestore.instance;
  final fireUser = firestoreInstance.collection(memberRef);

  addUserToFirebase(Map<String, dynamic> map) {
    fireUser.doc(map[uidKey]).set(map);
  }
}