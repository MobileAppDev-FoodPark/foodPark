// ignore_for_file: avoid_print, library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:foodspark/Businesspages/controllers/aut_controller.dart';
import 'package:foodspark/Businesspages/views/sign_up_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> userLoginData = {"email": "", "password": ""};

  AuthController controller = Get.put(AuthController());

  login() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      _formKey.currentState!.save();
      print('Data for login $userLoginData');

      controller.login(userLoginData['email'], userLoginData['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.cyan[50],
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Food Park',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.cyan,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userLoginData['email'] = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password Required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userLoginData['password'] = value!;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: login,
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: Text(
                            "Don't Have an Account ? Sign up",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
