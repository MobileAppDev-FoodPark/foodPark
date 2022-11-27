// ignore_for_file: avoid_print, prefer_is_empty

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodspark/Businesspages/controllers/aut_controller.dart';
import 'package:foodspark/models/stall_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'comman_dailog.dart';

class DataController extends GetxController {
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {'userName': '', 'joinDate': ''};

  List<Stall> loginUserData = [];

  List<Stall> allProduct = [];

  AuthController authController = Get.find();

  @override //add override
  void onReady() {
    super.onReady();
    // getAllProduct();
    getUserProfileData();
  }

  // displaying user info in drawer

  Future<void> getUserProfileData() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('owner_list')
          .where('user_Id', isEqualTo: authController.ownerId)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });

      if (response.docs.length > 0) {
        print(response.docs[0].data());
        userProfileData['userName'] = response.docs[0]['user_name'];
        userProfileData['email'] = response.docs[0]['email'];
        userProfileData['joinDate'] = response.docs[0]['joinDate'];
        userProfileData['address'] = response.docs[0]['address'];
        //NO PHONE AND IMAGE RETURN
        //userProfileData['Phone'] = response.docs[0]['Phone'];
        //userProfileData['image'] = response.docs[0]['imageUrl'];
      }
    } on FirebaseException catch (e) {
      print("$e");
    } catch (error) {
      print("$error");
    }
  }

  //add stall function

  Future<void> addstall(Map stalldata, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref =
        FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();

    try {
      CommanDialog.showLoading();
      var response = await firebaseInstance.collection('product_list').add({
        'name': stalldata['name'],
        'address': stalldata['address'],
        "upload_date": stalldata['upload_date'],
        'stall_image': imageUrl,
        'user_Id': authController.ownerId,
        'phone': stalldata['phone'],
      });
      print("Firebase response1111 $response");
      CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }

  //manage stall function

  Future<void> userStall() async {
    print("loginUserData YEs $loginUserData");

    loginUserData = [];

    try {
      CommanDialog.showLoading();
      final List<Stall> lodadedProduct = [];
      var response = await firebaseInstance
          .collection('product_list')
          .where('user_Id', isEqualTo: authController.ownerId)
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          print(result.data());
          print("Product ID  ${result.id}");
          lodadedProduct.add(
            Stall(
              stallId: result.id,
              stallname: result['name'],
              stallimage: result['stall_image'],
              stalladdress: result['address'],
              phone: int.parse(result['phone']),
              stalluploaddate: result['upload_date'].toString(),
              ownerId: result['user_Id'],
            ),
          );
        }
      }
      loginUserData.addAll(lodadedProduct);
      update();
      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

  //displaying stall in homescreen

  /*Future<void> getAllProduct() async {
    print("All Product : $allProduct");

    allProduct = [];

    try {
      CommanDialog.showLoading();
      final List<Stall> lodadedProduct = [];
      var response = await firebaseInstance
          .collection('product_list')
          .where('user_Id', isNotEqualTo: authController.ownerId)
          .get();
      if (response.docs.length > 0) {
        for (var result in response.docs) {
          print(result.data());
          print(result.id);
          lodadedProduct.add(
            Stall(
              stallId: result.id,
              stallname: result['name'],
              stalladdress: result['address'],
              stallimage: result['stall_image'],
              phone: int.parse(result['phone']),
              stalluploaddate: result['upload_date'].toString(),
              ownerId: result['user_Id'],
            ),
          );
        }
        allProduct.addAll(lodadedProduct);
        update();
      }

      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }*/
}
