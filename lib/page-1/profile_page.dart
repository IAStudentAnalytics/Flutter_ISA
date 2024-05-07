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
  Map<String, dynamic>? user; // Direct reference to user data for easier access
  String? apiUrl; // API URL to be used for updating profile based on role

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
        // Determine the API URL based on the message
        if (data['message'].contains('teacher')) {
          apiUrl = 'http://192.168.1.19:5000/api/teachers/${user?['_id']}';
        } else if (data['message'].contains('student')) {
          apiUrl = 'http://192.168.1.19:5000/api/students/${user?['_id']}';
        }
      });
    }
  }

  void _updateProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ..._buildTextFields(),
                ElevatedButton(
                  onPressed: () {
                    _saveUpdatedProfile();
                    Navigator.pop(context);
                  },
                  child: Text('Save Changes'),
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
      TextField(
        controller: TextEditingController(text: user?['firstName']),
        decoration: InputDecoration(labelText: 'First Name'),
      ),
      TextField(
        controller: TextEditingController(text: user?['lastName']),
        decoration: InputDecoration(labelText: 'Last Name'),
      ),
      TextField(
        controller: TextEditingController(text: user?['email']),
        decoration: InputDecoration(labelText: 'Email'),
      ),
      TextField(
        controller: TextEditingController(),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
      ),
      TextField(
        controller: TextEditingController(text: user?['cin'].toString()),
        decoration: InputDecoration(labelText: 'CIN'),
        keyboardType: TextInputType.number,
      ),
      TextField(
        controller: TextEditingController(text: user?['class']),
        decoration: InputDecoration(labelText: 'Class'),
      ),
      if (user?.containsKey('idTea') ?? false) TextField(
        controller: TextEditingController(text: user?['idTea'].toString()),
        decoration: InputDecoration(labelText: 'Teacher ID'),
        readOnly: true,
      ),
      if (user?.containsKey('field') ?? false) TextField(
        controller: TextEditingController(text: user?['field']),
        decoration: InputDecoration(labelText: 'Field'),
      ),
    ];
  }

  void _saveUpdatedProfile() async {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.headline6),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user?['avatarUrl'] ?? "https://avatars.dicebear.com/api/male/guest.svg"),
                radius: 60,
              ),
              Text("Hello, ${user?['firstName'] ?? 'Guest'}!", style: Theme.of(context).textTheme.headline6),
              Text(user?['email'] ?? '', style: Theme.of(context).textTheme.bodyText1),
              ElevatedButton(
                onPressed: () => _updateProfile(context),
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
