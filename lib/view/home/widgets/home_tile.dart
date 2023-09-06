import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/model/model.dart';

class HomeListTile extends StatelessWidget {
  const HomeListTile({
    super.key,
    required this.studentList,
    required this.studentController, required this.index,
  });

  final RxList<Student> studentList;
  final StudentController studentController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)),
      tileColor: Colors.grey[850],
      title: Text(studentList[index].name),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: () async {
                await studentController
                    .deleteStudent(studentList[index].id!);
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      contentPadding: const EdgeInsets.all(10),
      horizontalTitleGap: 20,
      leading: studentList[index].image == null
          ?const CircleAvatar(
              radius: 30,
            )
          : CircleAvatar(
              radius: 30,
              backgroundImage:
                  FileImage(File(studentList[index].image!)),
            ),
    );
  }
}
