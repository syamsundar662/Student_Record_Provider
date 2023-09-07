import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record/controller/search_controller.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/view/get_started/get_started.dart';
import 'package:student_record/view/home/widgets/home_list_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController =
        Provider.of<StudentController>(context, listen: false);
    studentController.getAllStudents();

    return Scaffold(
      appBar: AppBar(
        title: Consumer<SearchControllerProvider>(
            builder: (context, value, _) {
          return value.isSearching?CupertinoSearchTextField(
          onChanged: (value) {
            if(value.isNotEmpty){
              studentController.searchResult(value);
            }else{
              studentController.getAllStudents(); 
            }
          },
        ):const Text("Student Portal");
        }),
        centerTitle: true,
        actions: [
          Consumer<SearchControllerProvider>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: value.toggleSearch,
                  icon: Icon(value.isSearching ? Icons.close : Icons.search));
            },
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const GetStarted()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<StudentController>(builder: (context, value, child) {
            final studentList = studentController.studentList;
            if (studentList.isEmpty) {
              return const Center(
                child: Center(
                  child: Text('No records found!'),
                ),
              );
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: HomeStudentListBuilder(
                      studentList: studentController.studentList,
                      studentController: studentController),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
