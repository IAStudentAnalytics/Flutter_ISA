import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pim/page-1/hometeacher.dart';
import 'package:pim/page-1/quiz.dart';
import 'dart:ui';

import 'package:pim/utils.dart';


class Scene1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // loginptN (1:133)
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(30*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              // autogroup94rk9ve (Riq1KTcLWVV1t4JMof94Rk)
              width: 361*fem,
              height: 544*fem,
              child: Image.asset(
                'assets/page-1/images/auto-group-94rk.png',
                width: 361*fem,
                height: 544*fem,
              ),
            ),
            Container(
              // autogroupudtaHGA (Riq1gT1N28X3Q6WaSmudtA)
              width: double.infinity,
              height: 383*fem,
              child: Stack(
                children: [
                  Positioned(
                    // autogroupvvirR7U (Riq1XxFX5KmQsz6JHGvvir)
                    left: 30*fem,
                    top: 72*fem,
                    child: Align(
                      child: SizedBox(
                        width: 304*fem,
                        height: 28*fem,
                        child: Container(
                          decoration: BoxDecoration (
                            image: DecorationImage (
                              fit: BoxFit.cover,
                              image: AssetImage (
                                'assets/page-1/images/passwordinput.png',
                              ),
                            ),
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration (
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Passsword',
                              hintStyle: TextStyle(color:Color(0xff475569)),
                            ),
                            style: SafeGoogleFont (
                              'Roboto',
                              fontSize: 14*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4285714286*ffem/fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // autogrouppzkqDZ8 (Riq1S85uDChdM5vTfBpzKQ)
                    left: 30*fem,
                    top: 13*fem,
                    child: Container(
                      width: 293*fem,
                      height: 30*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // idYrJ (9:507)
                            left: 9*fem,
                            top: 5*fem,
                            child: Align(
                              child: SizedBox(
                                width: 13*fem,
                                height: 20*fem,
                                child: Image.asset(
                                  'assets/page-1/images/id.png',
                                  width: 13*fem,
                                  height: 20*fem,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            // idinputboxr6J (9:506)
                            child: SizedBox(
                              width: 293*fem,
                              height: 30*fem,
                              child: Container(
                                decoration: BoxDecoration (
                                  color: Color(0xffffffff),
                                ),
                                child: TextField(
                                  decoration: InputDecoration (
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    // idinputZFc (1:135)
                    left: 31*fem,
                    top: 43*fem,
                    child: Align(
                      child: SizedBox(
                        width: 298*fem,
                        height: 1*fem,
                        child: Container(
                          decoration: BoxDecoration (
                            color: Color(0xff000113),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // passwordinputUdU (1:138)
                    left: 31*fem,
                    top: 105*fem,
                    child: Align(
                      child: SizedBox(
                        width: 298*fem,
                        height: 1*fem,
                        child: Container(
                          decoration: BoxDecoration (
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                                    Positioned(
  left: 30 * fem,
  top: 215 * fem,
  child: Align(
    child: SizedBox(
      width: 298 * fem,
      height: 40 * fem,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sceneteacherhome()),
          );
        },
        child: Image.asset(
          'assets/page-1/images/login-button.png',
          width: 298 * fem,
          height: 40 * fem,
        ),
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