import 'package:flutter/material.dart';
import 'package:mailme/constant/colors.dart';

import 'mail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mail Me',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness:Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: const MailPage(title: 'Mail Me'),
    );
  }
}

