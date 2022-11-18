// ignore_for_file: unnecessary_this, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodspark/Userpages/views/login_page.dart';
import 'package:foodspark/models/owner_model.dart';

class BusinessHome extends StatelessWidget {
  const BusinessHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// ignore: must_be_immutable
class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  User? user = FirebaseAuth.instance.currentUser;
  OwnerModel loggedInUser = OwnerModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("owners")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = OwnerModel.fromMap(value.data());
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

//header
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
            Text('${loggedInUser.address}'),
            Text('${loggedInUser.email}'),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      );
//Items
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          runSpacing: 25,
          children: [
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const BusinessHome(),
                    ))),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Stalls'),
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
