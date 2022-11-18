// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodspark/Businesspages/controllers/aut_controller.dart';
import 'package:foodspark/Businesspages/views/stall_images.dart';
import 'package:get/get.dart';

class Addstall extends StatefulWidget {
  const Addstall({super.key});

  @override
  State<Addstall> createState() => _AddstallState();
}

class _AddstallState extends State<Addstall> {
  AuthController controller = Get.find();

  var _ownerImageFile;

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> stallData = {
    "name": "",
    "address": "",
    "upload_date": DateTime.now().millisecondsSinceEpoch,
    "email": ""
  };

  void _pickedImage(File image) {
    _ownerImageFile = image;

    print('image got $_ownerImageFile');
  }

  addstall() {
    if (_ownerImageFile == null) {
      Get.snackbar(
        "Opps",
        "Image Required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).errorColor,
        colorText: Colors.white,
      );
      return;
    }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for new stall $stallData');

      controller.addstall(stallData, _ownerImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Food Stall',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Stall Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stall Name Required';
                  }
                  return null;
                },
                onSaved: (value) {
                  stallData['name'] = value!;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address Required';
                  }
                  return null;
                },
                onSaved: (value) {
                  stallData['address'] = value!;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email  Required';
                  }
                  return null;
                },
                onSaved: (value) {
                  stallData['email'] = value!;
                },
              ),
              SizedBox(
                height: 30,
              ),
              StallImage(_pickedImage),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: addstall,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
