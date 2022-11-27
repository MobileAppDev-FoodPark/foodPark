// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:foodspark/Businesspages/controllers/data_controller.dart';
import 'package:get/get.dart';

class Stallview extends StatelessWidget {
  final DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.userStall();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('STALLS'),
      ),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.loginUserData.isEmpty
            ? Center(
                child: Text('😔 NO DATA FOUND PLEASE ADD DATA 😔'),
              )
            : ListView.builder(
                itemCount: controller.loginUserData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            controller.loginUserData[index].stallimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Stall Name: ${controller.loginUserData[index].stallname}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Phone Number: ${controller.loginUserData[index].phone.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Edit'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
