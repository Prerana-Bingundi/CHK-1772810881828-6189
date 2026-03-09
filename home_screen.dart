import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language/language_provider.dart';
import '../language/app_translations.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    String lang =
        Provider.of<LanguageProvider>(context).locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.text(lang, 'title')),
      ),

      body: Center(
        child: Text(
          AppTranslations.text(lang, 'welcome'),
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}