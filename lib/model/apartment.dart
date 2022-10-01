import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gest_loc/util/constant.dart';

class Apartment {
  late String uid;
  late String name;
  late String address;
  late String description;
  late String imageUrl;
  late DocumentReference<Map<String, dynamic>> ref;

  Apartment(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    ref = snapshot.reference;
    uid = snapshot.id;
    Map<String, dynamic>? datas = snapshot.data();
    name = datas?[nameKey];
    address = datas?[addressKey];
    description = datas?[descriptionKey];
    imageUrl = datas?[imageUrlKey];
  }
}
