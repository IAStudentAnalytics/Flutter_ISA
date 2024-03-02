import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:pim/utils.dart';


class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 411;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // test9sC (7:50)
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xfff4f2f6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              // autogroup5ngw6Ge (REgkFDP4WJS9WqKtrq5NgW)
              width: 487*fem,
              height: 572*fem,
              child: Stack(
                children: [
                  Positioned(
                    // questionpyL (7:51)
                    left: 52*fem,
                    top: 258*fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(110*fem, 5*fem, 93*fem, 5*fem),
                      width: 316*fem,
                      height: 138*fem,
                      decoration: BoxDecoration (
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(14*fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f9d57e3),
                            offset: Offset(0*fem, 2*fem),
                            blurRadius: 6.5*fem,
                          ),
                        ],
                      ),
                      child: Text(
                        'Question',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 25*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5*ffem/fem,
                          color: Color(0xff5b1cae),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // bgaSE2 (7:62)
                    left: 45*fem,
                    top: 425*fem,
                    child: Align(
                      child: SizedBox(
                        width: 323*fem,
                        height: 64*fem,
                        child: Container(
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(18*fem),
                            color: Color(0xffff7979),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // optionaY2A (7:63)
                    left: 49*fem,
                    top: 430*fem,
                    child: Align(
                      child: SizedBox(
                        width: 316*fem,
                        height: 55*fem,
                        child: Container(
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(14*fem),
                            color: Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f9d57e3),
                                offset: Offset(0*fem, 2*fem),
                                blurRadius: 6.5*fem,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // aDPC (7:64)
                    left: 82*fem,
                    top: 447*fem,
                    child: Align(
                      child: SizedBox(
                        width: 11*fem,
                        height: 23*fem,
                        child: Text(
                          'A',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont (
                            'Poppins',
                            fontSize: 15*ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.5*ffem/fem,
                            color: Color(0xff5b1cae),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // backgrounddesigni54 (7:68)
                    left: 0*fem,
                    top: 0*fem,
                    child: Container(
                      width: 487*fem,
                      height: 525*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // group1EJJ (7:69)
                            left: 0*fem,
                            top: 0*fem,
                            child: Container(
                              width: 411*fem,
                              height: 445*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(18*fem),
                                gradient: LinearGradient (
                                  begin: Alignment(0, -1),
                                  end: Alignment(0, 1),
                                  colors: <Color>[Color(0xffdf0b0b), Color(0x00f6f1fb)],
                                  stops: <double>[0, 1],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // rectangle2scA (7:71)
                                    left: 0*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 411*fem,
                                        height: 55.25*fem,
                                        child: Container(
                                          decoration: BoxDecoration (
                                            gradient: LinearGradient (
                                              begin: Alignment(0, -1),
                                              end: Alignment(0, 1),
                                              colors: <Color>[Color(0xffdf0b0b), Color(0x00f6f1fb)],
                                              stops: <double>[0, 1],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // ellipse68nz (7:72)
                                    left: 49*fem,
                                    top: 46*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 262*fem,
                                        height: 248*fem,
                                        child: Image.asset(
                                          'assets/page-1/images/ellipse-6.png',
                                          width: 262*fem,
                                          height: 248*fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // ellipse11SYn (7:73)
                                    left: 78*fem,
                                    top: 72*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 204*fem,
                                        height: 196*fem,
                                        child: Image.asset(
                                          'assets/page-1/images/ellipse-11.png',
                                          width: 204*fem,
                                          height: 196*fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // ellipse12wEe (7:74)
                                    left: 104*fem,
                                    top: 98*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 152*fem,
                                        height: 144*fem,
                                        child: Image.asset(
                                          'assets/page-1/images/ellipse-12.png',
                                          width: 152*fem,
                                          height: 144*fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // ellipse9ShC (7:76)
                                    left: 285*fem,
                                    top: 25*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 52*fem,
                                        height: 52*fem,
                                        child: Container(
                                          decoration: BoxDecoration (
                                            borderRadius: BorderRadius.circular(26*fem),
                                            color: Color(0x5bfb7d55),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // quiz1M3U (7:78)
                                    left: 135*fem,
                                    top: 125*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 90*fem,
                                        height: 90*fem,
                                        child: Image.asset(
                                          'assets/page-1/images/quiz-1-4BG.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // ellipse7eYN (7:75)
                            left: 0*fem,
                            top: 0*fem,
                            child: Align(
                              child: SizedBox(
                                width: 153*fem,
                                height: 148*fem,
                                child: Image.asset(
                                  'assets/page-1/images/ellipse-7.png',
                                  width: 153*fem,
                                  height: 148*fem,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // ellipse10aB8 (7:77)
                            left: 135*fem,
                            top: 0*fem,
                            child: Align(
                              child: SizedBox(
                                width: 129*fem,
                                height: 117*fem,
                                child: Image.asset(
                                  'assets/page-1/images/ellipse-10.png',
                                  width: 129*fem,
                                  height: 117*fem,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroup9mmg6fG (REgkuhGwcJfXda3dND9mMG)
              padding: EdgeInsets.fromLTRB(45*fem, 16*fem, 43*fem, 54*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupwb3uCyC (REgkYni7P8FBhwnEedwb3U)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 7*fem),
                    width: double.infinity,
                    height: 64*fem,
                    decoration: BoxDecoration (
                      color: Color(0xfff4f2f6),
                      borderRadius: BorderRadius.circular(18*fem),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          // optionbiwY (7:61)
                          left: 4*fem,
                          top: 5*fem,
                          child: Align(
                            child: SizedBox(
                              width: 316*fem,
                              height: 55*fem,
                              child: Container(
                                decoration: BoxDecoration (
                                  borderRadius: BorderRadius.circular(14*fem),
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3f9d57e3),
                                      offset: Offset(0*fem, 2*fem),
                                      blurRadius: 6.5*fem,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // bpUn (7:65)
                          left: 39.5*fem,
                          top: 22*fem,
                          child: Align(
                            child: SizedBox(
                              width: 10*fem,
                              height: 23*fem,
                              child: Text(
                                'B',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Poppins',
                                  fontSize: 15*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5*ffem/fem,
                                  color: Color(0xff5b1cae),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroup3xsvvni (REgkecsjFFJyEqx5Gj3XSv)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                    width: double.infinity,
                    height: 64*fem,
                    decoration: BoxDecoration (
                      color: Color(0xfff4f2f6),
                      borderRadius: BorderRadius.circular(18*fem),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          // optionc2qk (7:59)
                          left: 4*fem,
                          top: 5*fem,
                          child: Align(
                            child: SizedBox(
                              width: 316*fem,
                              height: 55*fem,
                              child: Container(
                                decoration: BoxDecoration (
                                  borderRadius: BorderRadius.circular(14*fem),
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3f9d57e3),
                                      offset: Offset(0*fem, 2*fem),
                                      blurRadius: 6.5*fem,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // cXnW (7:66)
                          left: 38.5*fem,
                          top: 23*fem,
                          child: Align(
                            child: SizedBox(
                              width: 12*fem,
                              height: 23*fem,
                              child: Text(
                                'C',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Poppins',
                                  fontSize: 15*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5*ffem/fem,
                                  color: Color(0xff5b1cae),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupsg4v2zA (REgkjT51hrzZenmzpHSg4v)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 42*fem),
                    width: double.infinity,
                    height: 64*fem,
                    decoration: BoxDecoration (
                      color: Color(0xfff4f2f6),
                      borderRadius: BorderRadius.circular(18*fem),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f9d57e3),
                          offset: Offset(0*fem, 2*fem),
                          blurRadius: 6.5*fem,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          // optiondwLS (7:57)
                          left: 4*fem,
                          top: 5*fem,
                          child: Align(
                            child: SizedBox(
                              width: 316*fem,
                              height: 55*fem,
                              child: Container(
                                decoration: BoxDecoration (
                                  borderRadius: BorderRadius.circular(14*fem),
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3f9d57e3),
                                      offset: Offset(0*fem, 2*fem),
                                      blurRadius: 6.5*fem,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // dqRp (7:67)
                          left: 39*fem,
                          top: 23*fem,
                          child: Align(
                            child: SizedBox(
                              width: 11*fem,
                              height: 23*fem,
                              child: Text(
                                'D',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Poppins',
                                  fontSize: 15*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5*ffem/fem,
                                  color: Color(0xff5b1cae),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroup3pwpvCN (REgkos7KkBbk6fsnk83pwp)
                    margin: EdgeInsets.fromLTRB(66*fem, 0*fem, 61*fem, 0*fem),
                    width: double.infinity,
                    height: 64*fem,
                    decoration: BoxDecoration (
                      color: Color(0xff020202),
                      borderRadius: BorderRadius.circular(50*fem),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f9d57e3),
                          offset: Offset(0*fem, 2*fem),
                          blurRadius: 6.5*fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 25*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5*ffem/fem,
                          color: Color(0xfffff9f9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
          );
  }
}