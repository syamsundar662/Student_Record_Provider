import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/view/home/widgets/home_list_builder.dart';

class HomePage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    studentController.getAllStudents();

    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        final studentList = studentController.studentList;
        if (studentList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: HomeStudentListBuilder(studentList: studentList, studentController: studentController),
          );
        }
      }),
    );
  }
}

