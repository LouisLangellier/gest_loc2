import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gest_loc/util/constant.dart';

class Member {
  late String uid;
  late String name;
  late String firstName;
  late DocumentReference<Map<String, dynamic>> ref;

  Member(DocumentSnapshot<Map<String, dynamic>> snapshot){
    ref = snapshot.reference;
    uid = snapshot.id;
    Map<String, dynamic>? datas = snapshot.data();
    name = datas?[nameKey];
    firstName = datas?[firstNameKey];
  }
}
