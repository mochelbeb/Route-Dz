import 'package:flutter/material.dart';

class MyShape extends CustomClipper<Path>{
    @override
    Path getClip(Size size) {
      final path = Path();
      path.lineTo(0, size.height - 60);
      path.quadraticBezierTo(size.width/2 , size.height + 60 , size.width , size.height - 60);
      path.lineTo(size.width, 0);
      path.close();
      return path;
    }
    
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
      return true;
    }
}