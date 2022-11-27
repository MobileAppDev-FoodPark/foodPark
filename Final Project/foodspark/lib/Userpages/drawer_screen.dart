// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodspark/Userpages/home_page.dart';
import 'package:foodspark/Userpages/login_page.dart';
import 'package:foodspark/models/user_model.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
// ignore: library_private_types_in_public_api
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      // ignore: unnecessary_this
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ]),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.cyan,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              child: Icon(Icons.person),
            ),
            SizedBox(
              height: 12,
            ),
            Text('${loggedInUser.username}'),
            Text('${loggedInUser.email}'),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          runSpacing: 25,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {},
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      );

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
