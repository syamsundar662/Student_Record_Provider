import 'package:flutter/material.dart';
import 'package:student_record/constants/const.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.controllers,
    required this.hint,
    this.value
  });
  final String Function(String?)? value;
  final String hint;
  final TextEditingController controllers;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sHeight*.07,
      child: TextFormField(
        validator: value,
        controller: controllers,
        decoration: InputDecoration(
            fillColor: const Color.fromARGB(59, 71, 71, 85),
            filled: true,
            hintText: hint,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
