import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/controller/student_controller.dart';
import 'package:student_record/model/model.dart';
import 'package:student_record/utils/image/imagePicker.dart';
import 'package:student_record/utils/validation/validation.dart';
import 'package:student_record/view/home/main_page.dart';
import 'package:student_record/view/update/widgets/form_fields.dart';

// ignore: must_be_immutable
class EditDetails extends StatelessWidget {

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
  }

  XFile? pickImg;
  @override
  Widget build(BuildContext context) {
    initializingValues();
    final studentListController =
        Provider.of<StudentController>(context, listen: false);
    studentListController.setImage(data.image!);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Details'),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          studentListController.studentImg = '';
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
                          studentListController.setImage(pickImg!.path);
                        }
                      },
                      child: Consumer<StudentController>(
                        builder: (context, value, child) 
                           {
                        return studentListController.studentImg.isEmpty
                            ? const CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/001/840/612/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg'),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                    File(studentListController.studentImg)),
                              );
                      }),
                    ),
                    kheight,
                    EditFormFieldWidget(
                      data: data.name,
                      controllers: nameController,
                      hint: 'Name',
                      function: isValidName,
                    ),
                    kheight,
                    EditFormFieldWidget(
                      data: data.age,
                      controllers: ageController,
                      hint: 'Age',
                      function: isValidAge,
                    ),
                    kheight,
                    EditFormFieldWidget(
                      data: data.phone,
                      controllers: phoneController,
                      hint: 'Phone',
                      function: isValidMobileNumber,
                    ),
                    kheight,
                    EditFormFieldWidget(
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
                          submitClick(context,studentListController);
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

  void submitClick(BuildContext context,StudentController studentListController) async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (studentListController.studentImg.isEmpty) {
      
    
      return;
    }
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final mail = mailController.text;
    final image = studentListController.studentImg;
   
    final updateStudentData =
        Student(name: name, age: age, phone: phone, mail: mail, image: image);
    await studentListController.updateStudent(updateStudentData, data.id!);
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Updated Successfully'),
          backgroundColor: Colors.green,
        ));
    pickImg = null;

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
    // studentListController.setImage('');
    
  }
}
