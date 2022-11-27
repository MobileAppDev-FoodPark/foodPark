// ignore_for_file: prefer_const_constructors, must_be_immutable, unnecessary_this
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodspark/welcomepage.dart';
import 'package:foodspark/widgets/iconlogo.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Park Mobile platform',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(
        duration: 4,
        goToPage: WelcomePage(),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  int duration = 0;
  Widget goToPage;

  SplashPage({super.key, required this.goToPage, required this.duration});

  @override
  Widget build(BuildContext context) {
//duration for opening
    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => this.goToPage));
    });
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Logo(),
      ),
    );
  }
}
