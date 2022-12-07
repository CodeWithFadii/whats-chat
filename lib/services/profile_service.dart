import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watts_clone/consts/auth_const.dart';

class ProfileService {
  static getProfileData(String id) {
    return firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: id)
        .get();
  }

  static getallUsers() {
    return firebaseFirestore
        .collection(collectionUser)
        .where('id', isNotEqualTo: user!.uid)
        .snapshots();
  }

  
}
