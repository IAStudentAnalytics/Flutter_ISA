import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';


class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 411;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // resultquiz3b4 (7:79)
        width: double.infinity,
        height: 869*fem,
        decoration: BoxDecoration (
          color: Color(0xfff4f2f6),
        ),
        child: Stack(
          children: [
            Positioned(
              // backgrounddesignNdL (7:80)
              left: 0*fem,
              top: 0*fem,
              child: Align(
                child: SizedBox(
                  width: 573*fem,
                  height: 961*fem,
                  child: Image.asset(
                    'assets/page-1/images/background-design.png',
                    width: 573*fem,
                    height: 961*fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // quiz1fMY (7:90)
              left: 49*fem,
              top: 96*fem,
              child: Align(
                child: SizedBox(
                  width: 90*fem,
                  height: 90*fem,
                  child: Image.asset(
                    'assets/page-1/images/quiz-1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              // ellipse13yt2 (7:91)
              left: 0*fem,
              top: 292*fem,
              child: Align(
                child: SizedBox(
                  width: 129*fem,
                  height: 117*fem,
                  child: Image.asset(
                    'assets/page-1/images/ellipse-13.png',
                    width: 129*fem,
                    height: 117*fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // ellipse15Hti (7:92)
              left: 324*fem,
              top: 364*fem,
              child: Align(
                child: SizedBox(
                  width: 110*fem,
                  height: 110*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(55*fem),
                      color: Color(0x5bc7a8fc),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // completed1o6N (7:93)
              left: 55*fem,
              top: 569*fem,
              child: Align(
                child: SizedBox(
                  width: 300*fem,
                  height: 300*fem,
                  child: Image.asset(
                    'assets/page-1/images/completed-1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          );
  }
}