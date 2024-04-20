import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:pim/utils.dart';

class Scenechat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // chat7ok (3:192)
        padding: EdgeInsets.fromLTRB(0*fem, 30*fem, 0*fem, 0*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          borderRadius: BorderRadius.circular(40*fem),
          gradient: LinearGradient (
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xffffffff), Color(0xbcffffff), Color(0x00ffffff)],
            stops: <double>[0, 0.265, 1],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // frame41NUn (3:197)
              margin: EdgeInsets.fromLTRB(29*fem, 0*fem, 27*fem, 12*fem),
              width: double.infinity,
              height: 52*fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // frame40W5C (3:198)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 81*fem, 0*fem),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // vuesaxlineararrowleftqNN (3:199)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 17*fem, 1*fem),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom (
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 24*fem,
                              height: 24*fem,
                              child: Image.asset(
                                'assets/page-1/images/vuesax-linear-arrow-left.png',
                                width: 24*fem,
                                height: 24*fem,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // bluerobotmascotlogoicondesign6 (3:201)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 20*fem, 1*fem),
                                width: 24*fem,
                                height: 36*fem,
                                child: Image.asset(
                                  'assets/page-1/images/blue-robot-mascot-logo-icon-design675467-55-1-traced-1-yt2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                // frame37ZBt (3:202)
                                width: 86*fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // javabotJ9U (3:203)
                                      'Java BOT',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 20*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xffee5e5e),
                                      ),
                                    ),
                                    Container(
                                      // frame36cvr (3:204)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24*fem, 0*fem),
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // ellipse1Z5Q (3:205)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 1*fem),
                                            width: 6*fem,
                                            height: 6*fem,
                                            decoration: BoxDecoration (
                                              borderRadius: BorderRadius.circular(3*fem),
                                              color: Color(0xff3abf37),
                                            ),
                                          ),
                                          Text(
                                            // onlineTAn (3:206)
                                            'Online',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff3abf37),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // frame38aFQ (3:207)
                    margin: EdgeInsets.fromLTRB(0*fem, 13.5*fem, 0*fem, 14.5*fem),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // vuesaxlinearvolumehighhav (3:208)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 19*fem, 0*fem),
                          width: 24*fem,
                          height: 24*fem,
                          child: Image.asset(
                            'assets/page-1/images/vuesax-linear-volume-high.png',
                            width: 24*fem,
                            height: 24*fem,
                          ),
                        ),
                        Container(
                          // vuesaxlinearexportQES (3:209)
                          width: 24*fem,
                          height: 24*fem,
                          child: Image.asset(
                            'assets/page-1/images/vuesax-linear-export.png',
                            width: 24*fem,
                            height: 24*fem,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // line1Xpr (3:214)
              width: double.infinity,
              height: 1*fem,
              decoration: BoxDecoration (
                color: Color(0xffebebeb),
              ),
            ),
            Container(
              // autogroupcxsetQW (REgnvJbJtjyEHZSPoyCXSE)
              padding: EdgeInsets.fromLTRB(18*fem, 21*fem, 24*fem, 0*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // frame53DSn (3:219)
                    margin: EdgeInsets.fromLTRB(76*fem, 0*fem, 0*fem, 27*fem),
                    width: 252*fem,
                    height: 54*fem,
                    decoration: BoxDecoration (
                      color: Color(0xfffea4a4),
                      borderRadius: BorderRadius.only (
                        topLeft: Radius.circular(25*fem),
                        bottomRight: Radius.circular(25*fem),
                        bottomLeft: Radius.circular(25*fem),
                      ),
                    ),
                  ),
                  Container(
                    // autogroup71ygKVp (REgnmeB5P1zEad8ToP71yg)
                    margin: EdgeInsets.fromLTRB(11*fem, 0*fem, 37*fem, 451.49*fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // frame55rEr (3:210)
                          margin: EdgeInsets.fromLTRB(0*fem, 46*fem, 7*fem, 0*fem),
                          padding: EdgeInsets.fromLTRB(7.11*fem, 3.92*fem, 7.11*fem, 3.92*fem),
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(245.282989502*fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0c000000),
                                offset: Offset(0*fem, 1.962264061*fem),
                                blurRadius: 0.9811320305*fem,
                              ),
                            ],
                          ),
                          child: Center(
                            // bluerobotmascotlogoicondesign6 (3:211)
                            child: SizedBox(
                              width: 11.77*fem,
                              height: 17.66*fem,
                              child: Image.asset(
                                'assets/page-1/images/blue-robot-mascot-logo-icon-design675467-55-1-traced-1-69t.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // frame54q6n (3:225)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 17.51*fem),
                          width: 252*fem,
                          height: 54*fem,
                          decoration: BoxDecoration (
                            color: Color(0xffeeeeee),
                            borderRadius: BorderRadius.only (
                              topLeft: Radius.circular(25*fem),
                              topRight: Radius.circular(25*fem),
                              bottomRight: Radius.circular(25*fem),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // frame35LJS (3:215)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 34*fem),
                    width: double.infinity,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(30*fem),
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x21000000),
                          offset: Offset(5*fem, 4*fem),
                          blurRadius: 10*fem,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration (
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(22*fem, 16*fem, 16*fem, 16*fem),
                        hintText: 'Write your message',
                        hintStyle: TextStyle(color:Color(0xffa1a1a1)),
                      ),
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 13*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // frame60xKp (3:193)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 287*fem, 0*fem),
                    padding: EdgeInsets.fromLTRB(7.11*fem, 3.92*fem, 7.11*fem, 3.92*fem),
                    height: 25.51*fem,
                    decoration: BoxDecoration (
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(245.282989502*fem),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0c000000),
                          offset: Offset(0*fem, 1.962264061*fem),
                          blurRadius: 0.9811320305*fem,
                        ),
                      ],
                    ),
                    child: Center(
                      // bluerobotmascotlogoicondesign6 (3:194)
                      child: SizedBox(
                        width: 11.77*fem,
                        height: 17.66*fem,
                        child: Image.asset(
                          'assets/page-1/images/blue-robot-mascot-logo-icon-design675467-55-1-traced-1-HZG.png',
                          fit: BoxFit.cover,
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




