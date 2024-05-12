import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pim/apiConstants.dart';
import 'package:pim/page-1/performance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentsListPage extends StatefulWidget {
  @override
  _StudentsListPageState createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  Map<String, dynamic>? userData;
  String? teacherId;
  Map<String, List<Map<String, String>>> classStudents = {};

  Future<void> fetchStudents() async {
    try {
      print('Starting to fetch students for teacher...');
      if (teacherId != null) {
        final url = Uri.parse('${APIConstants.baseURL}/api/teachers/getTeachersStudents/$teacherId');
        print('Fetching students for teacher (URL: $url)');

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print('Received response (data: $data)');

          for (var key in data.keys) {
            final classStudentsList = (data[key] as List).map((student) {
              final studentMap = {
                'firstName': student['firstName'] as String,
                'lastName': student['lastName'] as String,
                'email': student['email'] as String,
                'studentId': student['_id'] as String, // Add student ID
              };
              return studentMap;
            }).toList();
            classStudents[key] = classStudentsList;
          }

          setState(() {});
        } else {
          throw Exception('Failed to load students for teacher (Status Code: ${response.statusCode})');
        }
      } else {
        print('Warning: Teacher ID not found in userData');
      }
    } catch (error) {
      print('Error fetching students: $error');
    }
  }

  Future<void> _getUserDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      setState(() {
        userData = json.decode(userDataString);
        _extractTeacherId();
        fetchStudents();
      });
    }
  }

  void _extractTeacherId() {
    if (userData != null && userData!['user'] != null && userData!['user']['_id'] != null) {
      teacherId = userData!['user']['_id'] as String;
    } else {
      print('Warning: Teacher ID not found in userData');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserDataFromSharedPreferences();
  }

  void _navigateToPerformancePage(String studentId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Performance(studentId: studentId)),
    );
  }

  Widget _buildTab(String className) {
    return Text(
      className,
      style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStudentList(String className) {
    final studentList = classStudents[className] ?? [];
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x00f6f1fb),Color(0xffdf0b0b)],
          stops: [0, 1],
        ),
      ),
      child: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          final student = studentList[index];
          return ListTile(
            title: Text(
              '${student['firstName']} ${student['lastName']}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(student['email']!),
            onTap: () {
              _navigateToPerformancePage(student['studentId']!);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classList = classStudents.keys.toList();

    return DefaultTabController(
      length: classList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Students List'),
          bottom: TabBar(
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              color: Colors.redAccent[50],
            ),
            isScrollable: true,
            tabs: classList.map((className) => _buildTab(className)).toList(),
          ),
        ),
        body: Container(
          color: Colors.redAccent[50],
          child: TabBarView(
            children: classList.map((className) => _buildStudentList(className)).toList(),
          ),
        ),
      ),
    );
  }
}