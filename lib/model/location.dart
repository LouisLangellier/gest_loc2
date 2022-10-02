import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gest_loc/util/constant.dart';

class Location {
  late String uid;
  late String tenantName;
  late String tenantFirstName;
  late String tenantMail;
  late String tenantPhone;
  late String apartmentUid;
  late int dateBegin;
  late int dateEnd;
  late DocumentReference<Map<String, dynamic>> ref;

  Location(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    uid = snapshot.id;
    ref = snapshot.reference;
    Map<String, dynamic>? datas = snapshot.data();
    tenantName = datas?[tenantNameKey];
    tenantFirstName = datas?[tenantFirstNameKey];
    tenantMail = datas?[tenantMailKey];
    tenantPhone = datas?[tenantPhoneKey];
    apartmentUid = datas?[apartmentUidKey];
    dateBegin = datas?[dateBeginKey];
    dateEnd = datas?[dateEndKey];
  }
}
