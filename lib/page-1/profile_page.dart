import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        apiUrl = data['message'].contains('teacher') ? 
          'http://192.168.1.19:5000/api/teachers/${user?['_id']}' : 
          'http://192.168.1.19:5000/api/students/${user?['_id']}';
      });
    }
  }

  void _updateProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
            )
          ),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                  child: isUpdating ? CircularProgressIndicator(color: Colors.white) : Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12)
                  ),
                )
              ],
            ),
          ),
        );
      }
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

  Widget _buildTextField(String label, String? value, {bool isPassword = false, bool isNumber = false, bool isReadOnly = false}) {
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

  void _saveUpdatedProfile() async {
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile successfully updated')));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    } finally {
      setState(() {
        isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.headline6),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user?['avatarUrl'] ?? "https://avatars.dicebear.com/api/male/guest.svg"),
                radius: 80,
              ),
              SizedBox(height: 20),
              Text("Hello, ${user?['firstName'] ?? 'Guest'}!", style: Theme.of(context).textTheme.headline5),
              Text(user?['email'] ?? '', style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _updateProfile(context),
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
