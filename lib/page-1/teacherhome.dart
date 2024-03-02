import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';


class Sceneteacherhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 411;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // teacherhomeZaN (1:2)
        width: double.infinity,
        height: 869*fem,
        child: Image.asset(
          'assets/page-1/images/teacherhome.png',
          width: 411*fem,
          height: 869*fem,
        ),
      ),
          );
  }
}