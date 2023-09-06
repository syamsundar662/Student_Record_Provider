import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/model/model.dart';
import 'package:student_record/utils/image/imagePicker.dart';
import 'package:student_record/view/edit_page/widgets/form_fields.dart';
import 'package:student_record/utils/validation/validation.dart';

// ignore: must_be_immutable
class EditDetails extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  EditDetails({super.key, required this.data});
  final Student data;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();

  // initializingValues() {
  //   nameController.text = data.name;
  //   ageController.text = data.age;
  //   phoneController.text = data.phone;
  //   mailController.text = data.mail;
  //   studentController.studentImg.value = data.image!;
  // }

  XFile? pickImg;
  @override
  Widget build(BuildContext context) {
    List<dynamic> currentValues = [
      data.name,data.age,data.phone,data.mail
    ];
    // initializingValues();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Details'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          studentController.studentImg.value = '';
          return true;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    kheight,
                    InkWell(
                      onTap: () async {
                        pickImg = await imagePicker();
                        if (pickImg != null) {
                          studentController.studentImg(pickImg!.path);
                        }
                      },
                      child: Obx(() {
                        return studentController.studentImg.value.isEmpty
                            ? const CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/001/840/612/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg'),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                    File(studentController.studentImg.value)),
                              );
                      }),
                    ),
                    kheight,
                    EditFormFieldWidget(
                      initalValue: currentValues[0] ,
                      data: data.name,
                      controllers: nameController,
                      hint: 'Name',
                      function: isValidName,
                    ),
                    kheight,
                    EditFormFieldWidget(
                       initalValue: currentValues[1] ,
                      data: data.age,
                      controllers: ageController,
                      hint: 'Age',
                      function: isValidAge,
                    ),
                    kheight,
                    EditFormFieldWidget(
                       initalValue: currentValues[2] ,
                      data: data.phone,
                      controllers: phoneController,
                      hint: 'Phone',
                      function: isValidMobileNumber,
                    ),
                    kheight,
                    EditFormFieldWidget(
                       initalValue: currentValues[3] ,
                      data: data.mail,
                      controllers: mailController,
                      hint: 'Gmail',
                      function: isValidEmail,
                    ),
                    kheight,
                    SizedBox(
                      height: sHeight * .059,
                      width: sWidth / 2.5,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        onPressed: () {
                          submitClick(context);
                        },
                        color: const Color.fromARGB(84, 104, 126, 169),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitClick(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.validate();
    if (studentController.studentImg.value.isEmpty) {
      return;
    }
  
    final updateStudentData =
        Student(name: nameController.text,
         age: ageController.text,         
          phone: phoneController.text,
           mail: mailController.text,
            image: studentController.studentImg.value
            );
    await studentController.updateStudent(updateStudentData, data.id!);
    Get.back();
    pickImg = null;
    studentController.studentImg.value = '';
    Get.snackbar(
      "Update",
      'Updated Successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
