import 'package:flutter/material.dart';

const kheight = SizedBox(height: 10,);
const kwidget = SizedBox(width : 10,);
late double sHeight;
late double sWidth;
void size(BuildContext context){
  sHeight =  MediaQuery.of(context).size.height;
  sWidth =  MediaQuery.of(context).size.width;
}
