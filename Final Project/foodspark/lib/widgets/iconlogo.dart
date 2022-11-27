import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('images/splash_page.png', fit: BoxFit.cover)),
        ],
      ),
    ));
  }
}
