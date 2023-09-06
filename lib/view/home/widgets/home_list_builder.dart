import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/model/model.dart';
import 'package:student_record/view/full_details/full_details.dart';
import 'package:student_record/view/home/widgets/home_tile.dart';

class HomeStudentListBuilder extends StatelessWidget {
  const HomeStudentListBuilder({
    super.key,
    required this.studentList,
    required this.studentController,
  });

  final RxList<Student> studentList;
  final StudentController studentController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemCount: studentList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullDetails(
                student: studentList[index],
              ),
            ),
          ),
          child: HomeListTile(
            studentList: studentList,
            studentController: studentController,
            index: index,
          ),
        );
      },
    );
  }
}
