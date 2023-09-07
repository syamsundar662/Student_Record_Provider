import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record/controller/db_functions.dart';
import 'package:student_record/controller/search_controller.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/view/get_started/get_started.dart';

void main() async {
  runApp(const MyApp());
  await Sql().initialiseDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchControllerProvider>(create: (context) {
          return
          SearchControllerProvider();

        },),
        ChangeNotifierProvider<StudentController>(create: (context) => StudentController(),)
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.black),
          colorScheme: const ColorScheme.dark(
              background: Colors.black87, primary: Colors.white),
          useMaterial3: true,
        ),
        home: const GetStarted(),
      ),
    );
  }
}
