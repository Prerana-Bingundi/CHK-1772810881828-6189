import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Krishi Sahayak Dashboard"),
      ),

      body: Center(
        child: Text(
          "Welcome Farmer 🌾",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}