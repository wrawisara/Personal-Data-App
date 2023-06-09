import 'package:flutter/material.dart';
import 'package:personal_data_app/page/nameListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quick Queue",
      theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: Colors.blue),
        home: NameListPage(),
    );
  }
}
