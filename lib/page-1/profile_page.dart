import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  Map<String, dynamic>? user;
  String? apiUrl;
  bool isUpdating = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    _initUserData();
  }

  Future<void> _initUserData() async {
    prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      final Map<String, dynamic> data = json.decode(userDataString);
      setState(() {
        user = data['user'];
        apiUrl = data['message'].contains('teacher')
            ? 'http://192.168.1.19:5000/api/teachers/${user?['_id']}'
            : 'http://192.168.1.19:5000/api/students/${user?['_id']}';
      });
    }
  }

  void _updateProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AnimatedPadding(
          duration: Duration(milliseconds: 100),
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30),
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ..._buildTextFields(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _saveUpdatedProfile();
                    Navigator.pop(context);
                  },
                  child: isUpdating
                      ? CircularProgressIndicator(
                          color: const Color.fromARGB(255, 5, 5, 5))
                      : Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(155, 30, 125, 226),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 12)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showInformationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "About the App",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "An educational platform for teachers and students to manage resources, tests, and performance. Teachers create tests and manage students, while students access study materials, take tests, and track progress.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close", style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _buildTextField('First Name', user?['firstName']),
      _buildTextField('Last Name', user?['lastName']),
      _buildTextField('Email', user?['email']),
      _buildTextField('Password', '', isPassword: true),
      _buildTextField('CIN', user?['cin'].toString(), isNumber: true),
      _buildTextField('Class', user?['class']),
      if (user?.containsKey('idTea') ?? false)
        _buildTextField('Teacher ID', user?['idTea'].toString(), isReadOnly: true),
      if (user?.containsKey('field') ?? false)
        _buildTextField('Field', user?['field']),
    ];
  }

  Widget _buildTextField(String label, String? value,
      {bool isPassword = false, bool isNumber = false, bool isReadOnly = false}) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword,
      readOnly: isReadOnly,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }

  Future<void> _saveUpdatedProfile() async {
    setState(() {
      isUpdating = true;
    });
    try {
      final response = await http.put(
        Uri.parse(apiUrl ?? ''),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );

      if (response.statusCode == 200) {
        setState(() {
          user = json.decode(response.body);
          prefs.setString('userData', jsonEncode({'user': user}));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Profile successfully updated')));
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to update profile')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    } finally {
      setState(() {
        isUpdating = false;
      });
    }
  }

  Future<void> _getImage() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        if (image != null) {
          _image = File(image.path);
        } else {
          print('No image selected.');
        }
      });
    } else {
      print('Permission denied');
    }
  }

  Future<void> _saveImageLocally() async {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile = File('${directory.path}/profile.png');
    await imageFile.writeAsBytes(_image!.readAsBytesSync());

    setState(() {
      user?['profileImage'] = imageFile.path;
    });

    prefs.setString('userData', jsonEncode({'user': user}));

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profile picture saved')));
  }

  Widget _buildProfileImage() {
    final String? profileImagePath = user?['profileImage'];

    if (profileImagePath != null && File(profileImagePath).existsSync()) {
      return CircleAvatar(
        backgroundImage: FileImage(File(profileImagePath)),
        radius: 80,
      );
    }

    return GestureDetector(
      onTap: _getImage,
      child: CircleAvatar(
        child: _image != null ? null : Icon(Icons.add),
        backgroundImage: _image != null ? FileImage(_image!) : null,
        radius: 80,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.headline6),
        backgroundColor: Color.fromARGB(255, 95, 27, 27),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(),
              SizedBox(height: 20),
              Text("Hello, ${user?['firstName'] ?? 'Guest'}!", style: Theme.of(context).textTheme.headline5),
              Text(user?['email'] ?? '', style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _updateProfile(context),
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 163, 42, 42),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 25)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showInformationDialog,
                child: Text('Information'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 25)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveImageLocally,
                child: Text('Save Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
