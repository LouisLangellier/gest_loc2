import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gest_loc/util/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FirebaseHandler {
  //Authentication

  final authInstance = FirebaseAuth.instance;

  Future<User?> signIn(String mail, String password) async {
    final userCredential = await authInstance.signInWithEmailAndPassword(
        email: mail, password: password);
    final User? user = userCredential.user;
    return user;
  }

  Future<User?> createUser(
      String mail, String password, String name, String firstName) async {
    final userCredential = await authInstance.createUserWithEmailAndPassword(
        email: mail, password: password);
    final User? user = userCredential.user;
    if (user != null) {
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

  logOut() {
    authInstance.signOut();
  }

  //Database
  static final firestoreInstance = FirebaseFirestore.instance;
  final fireMember = firestoreInstance.collection(memberRef);

  static final storageRef = FirebaseStorage.instance.ref();

  //User
  //Ajout d'un utilisateur dans Firebase
  addUserToFirebase(Map<String, dynamic> map) {
    fireMember.doc(map[uidKey]).set(map);
  }

  //Apartment
  // Chaque appartement appartient à un membre
  // Les appartements sont ajoutes dans une collection du membre
  addApartmentToFirebase(String memberUid, String name, String address,
      String? description, XFile? file) async {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    Map<String, dynamic> apartmentMap = {
      nameKey: name,
      addressKey: address,
      uidKey: const Uuid().v1(),
      memberUidKey: memberUid,
      dateKey: date
    };
    if (description != "") {
      apartmentMap[descriptionKey] = description;
    }
    if (file != null) {
      final ref = storageRef
          .child(memberUid)
          .child(apartmentMap[uidKey])
          .child(date.toString());
      final urlString = await addImageToStorage(ref, file);
      apartmentMap[imageUrlKey] = urlString;
      fireMember
          .doc(memberUid)
          .collection(apartmentRef)
          .doc(apartmentMap[uidKey])
          .set(apartmentMap);
    } else {
      const urlString = "";
      apartmentMap[imageUrlKey] = urlString;
      fireMember
          .doc(memberUid)
          .collection(apartmentRef)
          .doc(apartmentMap[uidKey])
          .set(apartmentMap);
    }
  }

  Future<String> addImageToStorage(Reference ref, XFile file) async {
    File newFile = File(file.path);
    UploadTask task = ref.putFile(newFile);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    String urlString = await snapshot.ref.getDownloadURL();
    return urlString;
  }

  deleteApartmentFromFirebase(String memberUid, String apartmentUid, int date) {
    storageRef.child(memberUid).child(apartmentUid).child(date.toString()).delete();
    fireMember
        .doc(memberUid)
        .collection(apartmentRef)
        .doc(apartmentUid)
        .delete();
  }

  //Tenant
  // Les locataires sont ajoutes par rapport à l'appartement qu'ils louent
  // Ils sont ajoutes dans une collection d'un appartement
  addTenantToFirebase(
      Map<String, dynamic> map, String memberUid, String apartmentUid) {
    fireMember.doc(memberUid).collection(locationRef).doc(map[uidKey]).set(map);
  }

  //TODO ajouter les images des appartements dans Firebase

  //TODO ajouter les images pour le profil ??
}
