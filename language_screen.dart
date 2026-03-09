import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language/language_provider.dart';
import 'home_screen.dart';

class LanguageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Select Language")),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ElevatedButton(
            child: Text("English"),
            onPressed: () {
              Provider.of<LanguageProvider>(context, listen:false)
                  .changeLanguage('en');

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          ),

          ElevatedButton(
            child: Text("हिंदी"),
            onPressed: () {
              Provider.of<LanguageProvider>(context, listen:false)
                  .changeLanguage('hi');

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          ),

          ElevatedButton(
            child: Text("मराठी"),
            onPressed: () {
              Provider.of<LanguageProvider>(context, listen:false)
                  .changeLanguage('mr');

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          ),

        ],
      ),
    );
  }
}