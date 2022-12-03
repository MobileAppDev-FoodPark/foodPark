// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:foodspark/Businesspages/controllers/aut_controller.dart';
import 'package:foodspark/Userpages/home_page.dart';
import 'package:foodspark/map/maphomepage.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthController controller = Get.put(AuthController());
  int index = 0;
  final screens = [HomeScreen(), MapPage()];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.cyanAccent,
              labelTextStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          child: NavigationBar(
              height: 60,
              backgroundColor: Colors.cyan.shade200,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.store_outlined), label: 'FoodPark'),
                NavigationDestination(
                    icon: Icon(Icons.map_outlined), label: 'Map'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Account'),
              ]),
        ),
      );
}
