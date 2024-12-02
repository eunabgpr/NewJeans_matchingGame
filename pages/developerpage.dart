import 'package:flutter/material.dart';

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/AboutUs2.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
