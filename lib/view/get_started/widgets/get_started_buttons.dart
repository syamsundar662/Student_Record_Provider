import 'package:flutter/material.dart';
import 'package:student_record/constants/const.dart';

class GetStartButtons extends StatelessWidget {
  const GetStartButtons({
    super.key, required this.textTitle, this.onpress,
  });
  final String textTitle;
  final void Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sHeight*.063,
      width: sWidth/1.2,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7)),
        onPressed: onpress,
        color: const Color.fromARGB(60, 135, 134, 177),
        child:  Text(
          textTitle,
          style:const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
              color: Colors.white),
        ),
      ),
    );
  }
}
