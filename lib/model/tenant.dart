import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gest_loc/util/constant.dart';

class Tenant {
  late String uid;
  late String name;
  late String firstName;
  late int age;
  late String mail;
  late String phoneNumber;
  late String address;
  late DocumentReference<Map<String, dynamic>> ref;

  Tenant(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    ref = snapshot.reference;
    uid = snapshot.id;
    Map<String, dynamic>? datas = snapshot.data();
    name = datas?[nameKey];
    firstName = datas?[firstNameKey];
    age = datas?[ageKey];
    mail = datas?[mailKey];
    phoneNumber = datas?[phoneNumberKey];
    address = datas?[addressKey];
  }
}
