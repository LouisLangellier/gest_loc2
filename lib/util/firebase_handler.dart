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
      date = 0;
      apartmentMap[dateKey] = date;
      apartmentMap[imageUrlKey] = urlString;
      fireMember
          .doc(memberUid)
          .collection(apartmentRef)
          .doc(apartmentMap[uidKey])
          .set(apartmentMap);
    }
  }

  modifyApartmentToFirebase(String memberUid, String apartmentUid, String? url,
      String? name, String? address, String? description, XFile? file) async {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    Map<String, dynamic> apartmentMap = {};
    if (name != "" || name != null) {
      apartmentMap[nameKey] = name;
    }
    if (address != "" || address != null) {
      apartmentMap[addressKey] = address;
    }
    if (description != "" || description != null) {
      apartmentMap[descriptionKey] = description;
    }
    if (file != null) {
      modifyImageToStorage(file, apartmentUid, date);
      apartmentMap[dateKey] = date;
      fireMember
          .doc(memberUid)
          .collection(apartmentRef)
          .doc(apartmentUid)
          .update(apartmentMap);
    } else {
      fireMember
          .doc(memberUid)
          .collection(apartmentRef)
          .doc(apartmentUid)
          .update(apartmentMap);
    }
  }

  modifyApartmentUrl(String newUrl, String uid, String apartmentUid) {
    Map<String, dynamic> map = {
      imageUrlKey: newUrl
    };
    fireMember.doc(uid).collection(apartmentRef).doc(apartmentUid).update(map);
  }

  deleteApartmentFromFirebase(String memberUid, String apartmentUid, int date) {
    if (date != 0) {
      storageRef
          .child(memberUid)
          .child(apartmentUid)
          .child(date.toString())
          .delete();
    }
    fireMember
        .doc(memberUid)
        .collection(apartmentRef)
        .doc(apartmentUid)
        .delete();
  }

  //Tenant
  // Les locataires sont ajoutes par rapport à l'appartement qu'ils louent
  // Ils sont ajoutes dans une collection d'un appartement

  addLocationToFirebase(String memberUid, String apartmentUid, String name,
      String firstName, String mail, String phone, int dateBegin, int dateEnd) {
    Map<String, dynamic> map = {
      uidKey: const Uuid().v1(),
      tenantNameKey: name,
      tenantFirstNameKey: firstName,
      tenantMailKey: mail,
      tenantPhoneKey: phone,
      dateBeginKey: dateBegin,
      dateEndKey: dateEnd,
      apartmentUidKey: apartmentUid,
    };
    fireMember.doc(memberUid).collection(locationRef).doc(map[uidKey]).set(map);
  }

  //Storage

  Future<String> addImageToStorage(Reference ref, XFile file) async {
    File newFile = File(file.path);
    UploadTask task = ref.putFile(newFile);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    String urlString = await snapshot.ref.getDownloadURL();
    return urlString;
  }

  modifyImageToStorage(
      XFile file, String apartmentUid, int date) {
    String uid = authInstance.currentUser!.uid;
    final ref =
        storageRef.child(uid).child(apartmentUid).child(date.toString());
    final urlString = addImageToStorage(ref, file).then((value) {
      modifyApartmentUrl(value, uid, apartmentUid);
    });
  }

  deleteImageFromStorage(String url) {
    FirebaseStorage.instance.refFromURL(url).delete();
  }
}
