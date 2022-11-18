// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodspark/Businesspages/controllers/comman_dailog.dart';
import 'package:foodspark/Businesspages/views/home_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final firebaseInstance = FirebaseFirestore.instance;

  String? ownerId;

  Future<void> signUp(email, password, username, address) async {
    try {
      CommanDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      print(userCredential);
      ownerId = userCredential.user!.uid;
      CommanDialog.hideLoading();

      try {
        CommanDialog.showLoading();
        var response =
            await FirebaseFirestore.instance.collection('owner_list').add({
          'owner_Id': userCredential.user!.uid,
          'user_name': username,
          'address': address,
          "password": password,
          'joinDate': DateTime.now().millisecondsSinceEpoch,
          'email': email
        });
        print("Firebase response1111 ${response.id}");
        CommanDialog.hideLoading();
        Get.back();
      } catch (exception) {
        CommanDialog.hideLoading();
        print("Error Saving Data at firestore $exception");
      }
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'weak-password') {
        CommanDialog.showErrorDialog(
            description: "The password provided is too weak.");

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommanDialog.showErrorDialog(
            description: "The account already exists for that email.");

        print('The account already exists for that email.');
      }
    } catch (e) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog(description: "Something went wrong");
      print(e);
    }
  }

  //Login

  Future<void> login(email, password) async {
    print('$email,$password');
    try {
      CommanDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);

      print(userCredential.user!.uid);

      ownerId = userCredential.user!.uid;

      CommanDialog.hideLoading();

      Get.off(() => BusinessPage());
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommanDialog.showErrorDialog(
            description: "No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommanDialog.showErrorDialog(
            description: "Wrong password provided for that user.");

        print('Wrong password provided for that user.');
      }
    }
  }

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
      var response = await firebaseInstance
          .collection('owner_list')
          .doc(ownerId)
          .collection('stall')
          .add({
        'name': stalldata['name'],
        'address': stalldata['address'],
        "upload_date": stalldata['upload_date'],
        'stall_image': imageUrl,
        "email": stalldata['email'],
      });
      print("Firebase response1111 $response");
      CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }
}
