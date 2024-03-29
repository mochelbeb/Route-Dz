import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class Styles {
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFeeedf2);
  static TextStyle textStyle = TextStyle (fontSize: 16.sp , color : textColor , fontWeight: FontWeight.w500);
  static TextStyle headlineStyle1 = TextStyle (fontSize: 26 , color : textColor , fontWeight: FontWeight.bold);
  static TextStyle textStyle_revese = TextStyle (fontSize: 16 , color : bgColor , fontWeight: FontWeight.w500);
  static TextStyle title = TextStyle (fontSize: 30.sp , color : Color.fromRGBO(6, 40, 61, 1) , fontWeight: FontWeight.bold);
  static TextStyle subtitle = TextStyle (fontSize: 20.sp , color : Color.fromRGBO(6, 40, 61, 1) , fontWeight: FontWeight.bold);

}