import 'package:flutter/material.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/model/model.dart';

class FieldCard extends StatelessWidget {
  const FieldCard({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Cards(title: 'Name', value: student.name),
        Cards(title: 'Age', value: student.age),
        Cards(title: 'Phone', value: student.phone),
        Cards(title: 'Mail', value: student.mail),
      ],
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
      child: Container(
        height: sHeight*.09,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[900]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
