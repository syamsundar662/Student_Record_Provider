import 'package:flutter/material.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/view/get_started/widgets/get_start_main.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) { 
    size(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 35, 48),
            Color.fromARGB(255, 21, 0, 26),
            Color.fromARGB(255, 35, 0, 14),
          ],
        )),
        child:const GetStartMainSection(),
      ),
    );
  }
}
