import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/model/model.dart';
import 'package:student_record/view/edit_page/widgets/form_fields.dart';

// ignore: must_be_immutable
class EditDetails extends GetView<StudentController> {
  final StudentController studentController = Get.put(StudentController());
  EditDetails({super.key, required this.data});
  final Student data;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();

   initializingValues() {
    nameController.text = data.name;
    ageController.text = data.age;
    phoneController.text = data.phone;
    mailController.text = data.mail;
    // studentController.image.value = student.image;
  }

  XFile? pickImg;
  @override
  Widget build(BuildContext context) {
    initializingValues(); 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Details'),
      ),
      body: SafeArea(
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
                      await picImgToRxString();
                    },
                    child: Obx(() {
                      return studentController.studentImg.value.isEmpty
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/001/840/612/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg'
                                  ),
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
                    data: data.name,
                    controllers: nameController,
                    hint: 'Name',
                  ),
                  kheight,
                  EditFormFieldWidget(
                    data: data.age,
                    controllers: ageController,
                    hint: 'Age',
                  ),
                  kheight,
                  EditFormFieldWidget(
                    data: data.phone,
                    controllers: phoneController, 
                    hint: 'Phone'),
                  kheight,
                  EditFormFieldWidget(
                    data: data.mail,
                    controllers: mailController,
                    hint: 'Gmail',
                  ),
                  kheight,
                  SizedBox(
                    height: sHeight*.059,
                    width: sWidth/2.5,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      onPressed: () {
                        submitClick();
                      },
                      color:const Color.fromARGB(84, 104, 126, 169),
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
    );
  }

  Future<void> picImgToRxString() async {
    pickImg = await pickImage();
    if (pickImg != null) {
      studentController.studentImg.value = pickImg!.path;
    }
  }

  pickImage() async {
    try {
      final pic = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pic == null) {
        return Exception('no image');
      }
      return pic;
    } catch (e) {
      return (e);
    }
  }

  void submitClick() async { 

    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        phoneController.text.isEmpty) {
      return;
    }
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final mail = mailController.text;
    final image = pickImg;

    final updateStudentData = Student(
        name: name,
         age: age,
          phone: phone,
           mail: mail,
            image: image!.path);
    await studentController.updateStudent(updateStudentData,data.id!);
    studentController.studentImg.value = '';
    Get.snackbar('Done!', 'Successfully added');
    clear();
  }

  clear() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    mailController.clear();
  }
}
