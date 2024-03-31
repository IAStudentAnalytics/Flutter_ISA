import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:pim/utils.dart';

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // chathomeMRx (3:131)
        padding: EdgeInsets.fromLTRB(21*fem, 79*fem, 21*fem, 34*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          borderRadius: BorderRadius.circular(40*fem),
          gradient: LinearGradient (
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xffe74949), Color(0xffe74949), Color(0xffe74949), Color(0x00f1f1f1)],
            stops: <double>[0.035, 0.06, 0.145, 1],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // frame34BQz (3:133)
              margin: EdgeInsets.fromLTRB(46*fem, 0*fem, 45*fem, 82*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // javabotWTG (3:134)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 13*fem),
                    child: Text(
                      'JavaBot',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 23*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // usingthissoftwareyoucanaskyouq (3:135)
                    constraints: BoxConstraints (
                      maxWidth: 242*fem,
                    ),
                    child: Text(
                      'Using this software,you can ask you\nquestions and receive articles using\nartificial intelligence assistant',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 15*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff757575),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // frame335Pt (3:132)
              margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 130*fem),
              width: 320*fem,
              height: 324*fem,
              child: Image.asset(
                'assets/page-1/images/frame-33.png',
                fit: BoxFit.cover,
              ),
            ),
            TextButton(
              // frame35oKt (3:136)
              onPressed: () {},
              style: TextButton.styleFrom (
                padding: EdgeInsets.zero,
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(126.5*fem, 15*fem, 20*fem, 15*fem),
                width: double.infinity,
                decoration: BoxDecoration (
                  color: Color(0xff000000),
                  borderRadius: BorderRadius.circular(30*fem),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // continueJXY (3:137)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 82.5*fem, 0*fem),
                      child: Text(
                        'Continue',
                        style: SafeGoogleFont (
                          'Nunito',
                          fontSize: 19*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.3625*ffem/fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      // vuesaxlineararrowrightEAJ (3:138)
                      width: 24*fem,
                      height: 24*fem,
                      child: Image.asset(
                        'assets/page-1/images/vuesax-linear-arrow-right.png',
                        width: 24*fem,
                        height: 24*fem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
          );
  }
}