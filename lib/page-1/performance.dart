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
        // performanceZh8 (3:13)
        padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 102*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffeeeeee),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupd3k2gWr (REgn5ALXTzzUDyiu8wd3k2)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 125.5*fem),
              width: 505*fem,
              height: 449*fem,
              child: Image.asset(
                'assets/page-1/images/auto-group-d3k2.png',
                width: 505*fem,
                height: 449*fem,
              ),
            ),
            Center(
              // recommendationPgA (3:30)
              child: Container(
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 221*fem, 42.5*fem),
                child: Text(
                  'Recommendation',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont (
                    'Roboto',
                    fontSize: 12*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.1725*ffem/fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            Container(
              // rectangle7USi (3:31)
              margin: EdgeInsets.fromLTRB(25*fem, 0*fem, 25*fem, 0*fem),
              width: double.infinity,
              height: 184*fem,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(13*fem),
                color: Color(0xb5d2d2d2),
              ),
            ),
          ],
        ),
      ),
          );
  }
}