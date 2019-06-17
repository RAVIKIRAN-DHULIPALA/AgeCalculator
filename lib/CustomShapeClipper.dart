import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path>{
  @override
 Path getClip(Size size) {
    final Path path =Path();
    path.lineTo(0.0, size.height);
    var firstEndPoint = Offset(size.width *.5, size.height - 30.0);
    var firstcontrolPoint = Offset(size.width *0.25, size.height - 50.0);
    path.quadraticBezierTo(firstcontrolPoint.dx,firstcontrolPoint.dy,firstEndPoint.dx,firstEndPoint.dy);

    var secndendpoint = Offset(size.width,size.height - 85.0);
    var secondcontrolpoint =  Offset(size.width * .75,size.height - 10);
    path.quadraticBezierTo(secondcontrolpoint.dx,secondcontrolpoint.dy,secndendpoint.dx,secndendpoint.dy);

    path.lineTo(size.width,0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper)=> true;
  }
