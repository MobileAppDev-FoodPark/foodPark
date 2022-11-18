// ignore_for_file: unnecessary_this, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodspark/Userpages/views/login_page.dart';
import 'package:foodspark/Userpages/models/user_model.dart';
import 'package:foodspark/models/owner_model.dart';

class HomeScreen extends StatefulWidget {
  final String? userId;
  const HomeScreen({Key? key, this.userId}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('FOOD PARK'),
          backgroundColor: Colors.cyan,
        ),
        drawer: DrawerPage(),
        body: StreamBuilder<List<OwnerModel>>(
            stream: readOwnerModel(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong ${snapshot.error}');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;

                return ListView(
                  children: users.map(buildOwnerModel).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      );
  Widget buildOwnerModel(OwnerModel users) => SizedBox(
        height: 200,
        child: Card(
          color: Colors.cyan,
          child: ListTile(
            leading: Text(
              '${users.username}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            title: Text(
              '${users.address}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              '${users.email}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              // tap actions
            },
          ),
        ),
      );

  Stream<List<OwnerModel>> readOwnerModel() => FirebaseFirestore.instance
      .collection("owners")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => OwnerModel.fromMap(doc.data())).toList());
}

// ignore: must_be_immutable
class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
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
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ))),
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
