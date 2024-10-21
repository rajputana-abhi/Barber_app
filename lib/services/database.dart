import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserBooking(
    Map<String, dynamic> userinfomap,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .add(userinfomap);
  }

  Future<Stream<QuerySnapshot>> getbooking() async {
    return await FirebaseFirestore.instance.collection("Booking").snapshots();
  }

  Future deleteBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .doc(id)
        .delete();
  }
}
