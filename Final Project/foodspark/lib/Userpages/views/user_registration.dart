// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodspark/Userpages/views/login_page.dart';
import 'package:foodspark/Userpages/models/user_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key, required String title});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final username = new TextEditingController();
  final email = new TextEditingController();
  final password = new TextEditingController();
  final confirmPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //text field
    final textField = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('SIGN UP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.cyan,
            )),
        Icon(Icons.app_registration),
      ],
    );
    //username field
    final usernameField = TextFormField(
        autofocus: false,
        controller: username,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("User Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          username.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: new BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: email,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          username.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: new BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: password,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
          return null;
        },
        onSaved: (value) {
          username.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: new BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPassword,
        obscureText: true,
        validator: (value) {
          if (confirmPassword.text != password.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPassword.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: new BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ));

    //signup button
    final signUpButton = SizedBox(
      height: 40,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: Colors.cyan,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            minWidth: 200,
            onPressed: () {
              signUp(email.text, password.text);
            },
            child: Text(
              "Register",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.grey[350],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5),
                      textField,
                      SizedBox(height: 35),
                      usernameField,
                      SizedBox(height: 25),
                      emailField,
                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 25),
                      confirmPasswordField,
                      SizedBox(height: 20),
                      signUpButton,
                      SizedBox(height: 15),
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values

    userModel.email = user!.email;
    userModel.username = username.text;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
