import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/page-1/Studenthome.dart';
import 'package:pim/page-1/onbording.dart';
import 'package:pim/page-1/teacherhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scene1 extends StatefulWidget {
  @override
  _Scene1State createState() => _Scene1State();
}

class _Scene1State extends State<Scene1> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> login(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields'),
      ));
      return;
    }

    final String apiUrl = 'http://172.16.1.188:5000/api/user/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userData', jsonEncode(userData));

        // Determine the role from the login response and navigate accordingly
        if (userData['message'].contains('teacher')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Sceneteacherhome()),
          );
        } else if (userData['message'].contains('student')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => SceneStudentHome(email: '')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Unknown role, cannot navigate properly'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid email or password'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(30 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 361 * fem,
              height: 544 * fem,
              child: Image.asset(
                'assets/page-1/images/auto-group-94rk.png',
                width: 361 * fem,
                height: 544 * fem,
              ),
            ),
            Container(
              width: double.infinity,
              height: 383 * fem,
              child: Stack(
                children: [
                  Positioned(
                    left: 30 * fem,
                    top: 72 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 304 * fem,
                        height: 28 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/page-1/images/passwordinput.png',
                              ),
                            ),
                          ),
                          child: TextField(
                            obscureText: !_isPasswordVisible,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Color(0xff475569)),
                            ),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4285714286 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30 * fem,
                    top: 13 * fem,
                    child: Container(
                      width: 293 * fem,
                      height: 30 * fem,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 9 * fem,
                            top: 5 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 13 * fem,
                                height: 20 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/id.png',
                                  width: 13 * fem,
                                  height: 20 * fem,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            child: SizedBox(
                              width: 293 * fem,
                              height: 30 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                ),
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'E-mail',
                                    hintStyle: TextStyle(color: Color(0xff475569)),
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
                    left: 31 * fem,
                    top: 43 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 298 * fem,
                        height: 1 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff000113),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 31 * fem,
                    top: 105 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 298 * fem,
                        height: 1 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30 * fem,
                    top: 170 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 298 * fem,
                        height: 40 * fem,
                        child: GestureDetector(
                          onTap: () {
                            login(context); // Trigger the login function
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
                  Positioned(
                    right: 30 * fem,
                    top: 60 * fem,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xff475569),
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