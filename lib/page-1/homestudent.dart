import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';


class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 180;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // homestudentC8E (5:402)
        padding: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 0*fem),
        width: double.infinity,
        height: 43*fem,
        child: Align(
          // autogrouplhmxicN (REgovmut6srSoP2RswLhmx)
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 178*fem,
            height: 30*fem,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom (
                padding: EdgeInsets.zero,
              ),
              child: Image.asset(
                'assets/page-1/images/auto-group-lhmx.png',
                width: 178*fem,
                height: 30*fem,
              ),
            ),
          ),
        ),
      ),
          );
  }
}