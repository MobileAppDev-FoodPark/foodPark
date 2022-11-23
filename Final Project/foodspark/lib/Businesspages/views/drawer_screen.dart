// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:foodspark/Businesspages/controllers/data_controller.dart';
import 'package:foodspark/Businesspages/views/stall_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppDrawer extends StatelessWidget {
  final DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 220,
        child: Drawer(
          backgroundColor: Colors.cyan[50],
          child: ListView(
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Business Name : ${controller.userProfileData['userName']}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Email : ${controller.userProfileData['email']}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    FittedBox(
                      child: Text(
                        'Join Date : ${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(controller.userProfileData['joinDate']))} ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.store),
                title: const Text('Your Stall'),
                onTap: () {
                  Get.back();
                  Get.to(() => Stallview());
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
