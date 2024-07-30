import 'package:flutter/material.dart';
import 'package:zc_dodiddon/pages/login_page.dart';
import 'package:zc_dodiddon/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
