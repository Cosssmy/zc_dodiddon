import 'package:flutter/material.dart';
import 'package:zc_dodiddon/pages/login_page.dart';
import 'package:zc_dodiddon/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DoDidDoneTheme.lightTheme, // Apply the theme here
      home: LoginPage(),
    );
  }
}
