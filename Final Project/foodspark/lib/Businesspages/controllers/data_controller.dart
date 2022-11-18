// ignore_for_file: avoid_print

import 'package:foodspark/Businesspages/controllers/aut_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataController extends GetxController {
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {'userName': '', 'joinDate': ''};

  AuthController authController = AuthController();

  @override //add override
  void onReady() {
    super.onReady();

    getUserProfileData();
  }

  Future<void> getUserProfileData() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('owner_list')
          .where('owner_Id', isEqualTo: authController.ownerId)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
      // ignore: prefer_is_empty
      if (response.docs.length > 0) {
        userProfileData['userName'] = response.docs[0]['user_name'];
        userProfileData['email'] = response.docs[0]['email'];
        userProfileData['joinDate'] = response.docs[0]['joinDate'];
        userProfileData['address'] = response.docs[0]['address'];
        userProfileData['image'] = response.docs[0]['imageUrl'];
      }
      print(userProfileData);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
