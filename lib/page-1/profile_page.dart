import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pim/page-1/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool isDarkMode;
  String? firstName;
  String? email;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('dark_mode') ?? false;
      final userDataString = prefs.getString('userData');
      if (userDataString != null) {
        final userData = json.decode(userDataString);
        firstName = userData['user']['firstName'];
        email = userData['email'];
      }
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
      prefs.setBool('dark_mode', value);
    });
    Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.headline6),
        actions: [
          IconButton(
            onPressed: () => _toggleDarkMode(!isDarkMode),
            icon: Icon(isDarkMode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage("assets/profile_image.png")),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.blueAccent),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Hello, ${firstName ?? 'Guest'}!", style: Theme.of(context).textTheme.titleLarge),
              Text("Welcome to your profile", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/update_profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              buildMenuButton(context, 'Settings', LineAwesomeIcons.cog, '/settings'),
              buildMenuButton(context, 'Information', LineAwesomeIcons.info, '/information'),
              buildMenuButton(context, 'Logout', LineAwesomeIcons.alternate_sign_out, '/logout', textColor: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String title, IconData icon, String route, {Color? textColor}) {
    return ListTile(
      onTap: () {
        if (route == '/logout') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("LOGOUT"),
                content: const Text("Are you sure you want to Logout?"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      logout();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                    child: const Text("Yes"),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        } else {
          Get.toNamed(route);
        }
      },
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueAccent.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.blueAccent),
      ),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: Icon(LineAwesomeIcons.angle_right, size: 18.0),
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(() => Scene1());
  }
}
