import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/controller/db_functions.dart';
import 'package:student_record/view/get_started/get_started.dart';

void main() async {
  runApp(const MyApp());
  await Sql().initialiseDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.black),
        colorScheme: const ColorScheme.dark(
            background: Colors.black87, primary: Colors.white),
        useMaterial3: true,
      ),
      home: const GetStarted(),
    );
  }
}
