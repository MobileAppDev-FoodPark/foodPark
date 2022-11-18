// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodspark/Businesspages/controllers/data_controller.dart';
import 'package:foodspark/Businesspages/views/drawer_screen.dart';
import 'package:foodspark/Businesspages/views/addstall_page.dart';
import 'package:get/get.dart';

class BusinessPage extends StatelessWidget {
  BusinessPage({super.key});

  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      drawer: AppDrawer(),
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'FOOD STALLS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => Addstall());
                },
                icon: Icon(Icons.add))
          ]),
    );
  }
}
