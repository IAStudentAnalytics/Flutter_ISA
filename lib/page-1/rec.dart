/*import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/compilateurService.dart';

class RecommendedVideosPage extends StatefulWidget {
  @override
  _RecommendedVideosPageState createState() => _RecommendedVideosPageState();
}

class _RecommendedVideosPageState extends State<RecommendedVideosPage> {
  final CompilerService _videoService = CompilerService();
  Map<String, dynamic> recommendedVideos = {};
  Map<String, dynamic>? userData;

  Future<void> _getUserDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      setState(() {
        userData = json.decode(userDataString);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initUserData();
  }

  Future<void> _initUserData() async {
    await _getUserDataFromSharedPreferences();
    _fetchRecommendedVideos();
  }

  Future<void> _fetchRecommendedVideos() async {
    final String testId = '6628da731988d8132fef6b05';
    //final String studentId = '65defb8f796124616d1ecdc2';
    if (userData != null && userData!['_id'] != null) {
      String studentId = userData!['_id'];

      try {
        final videos =
            await _videoService.fetchRecommendedVideos(testId, studentId);
        setState(() {
          recommendedVideos = videos;
        });
      } catch (e) {
        print('Error fetching recommended videos: $e');
      }
    } else {
      print('User data or ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vidéos Recommandées'),
      ),
      body: ListView(
        children: recommendedVideos.entries.map<Widget>((entry) {
          String chapter = entry.key;
          List<dynamic> videos = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chapter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Column(
                children: videos.map<Widget>((video) {
                  return ListTile(
                    title: Text(video['videoTitle']),
                    subtitle: GestureDetector(
                      child: Text(
                        video['videoLink'],
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      /*
                      onTap: () async {
                        if (await canLaunch(video['videoLink'])) {
                          await launch(video['videoLink']);
                        } else {
                          throw 'Could not launch ${video['videoLink']}';
                        }
                      },*/
                      onTap: () async {
                        if (await canLaunch(video['videoLink'])) {
                          await launch(video['videoLink']);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Impossible d\'ouvrir le lien ${video['videoLink']}'),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}*/
 
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/compilateurService.dart';

class RecommendedVideosPage extends StatefulWidget {
  @override
  _RecommendedVideosPageState createState() => _RecommendedVideosPageState();
}

class _RecommendedVideosPageState extends State<RecommendedVideosPage> {
  final CompilerService _videoService = CompilerService();
  Map<String, dynamic> recommendedVideos = {};
  String? studentId;

  @override
  void initState() {
    super.initState();
    _initUserData();
  }

  Future<void> _initUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    print('xxxxxuserDataString: $userDataString'); // Débogage
    if (userDataString != null) {
      final Map<String, dynamic> userData = json.decode(userDataString);
      final Map<String, dynamic> user = userData['user'];
      setState(() {
         studentId = user['_id'];
      });
      if (studentId != null) {
        print('xxxStudent ID retrieved successfully: $studentId'); // Débogage
        _fetchRecommendedVideos();
      }
    } else {
      print('User data is null');
    }
  }

  Future<void> _fetchRecommendedVideos() async {
    if (studentId != null) {
      final String testId =
          '6628da731988d8132fef6b05'; // L'identifiant de test est ajouté ici comme exemple
      try {
        final videos =
            await _videoService.fetchRecommendedVideos(testId, studentId!);
        setState(() {
          recommendedVideos = videos;
        });
      } catch (e) {
        print('Error fetching recommended videos: $e');
      }
    } else {
      print('Student ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vidéos Recommandées'),
      ),
      body: ListView(
        children: recommendedVideos.entries.map<Widget>((entry) {
          String chapter = entry.key;
          List<dynamic> videos = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chapter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Column(
                children: videos.map<Widget>((video) {
                  return ListTile(
                    title: Text(video['videoTitle']),
                    subtitle: GestureDetector(
                      child: Text(
                        video['videoLink'],
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        if (await canLaunch(video['videoLink'])) {
                          await launch(video['videoLink']);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Impossible d\'ouvrir le lien ${video['videoLink']}'),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../services/compilateurService.dart';

class RecommendedVideosPage extends StatefulWidget {
  @override
  _RecommendedVideosPageState createState() => _RecommendedVideosPageState();
}

class _RecommendedVideosPageState extends State<RecommendedVideosPage> {
  final CompilerService _videoService = CompilerService();
  Map<String, dynamic> recommendedVideos = {};

  @override
  void initState() {
    super.initState();
    _fetchRecommendedVideos();
  }

  Future<void> _fetchRecommendedVideos() async {
    final String testId = '6628da731988d8132fef6b05';
    final String studentId = '65df009a796124616d1ecdce';

    try {
      final videos =
          await _videoService.fetchRecommendedVideos(testId, studentId);
      setState(() {
        recommendedVideos = videos;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vidéos Recommandées'),
      ),
      body: ListView(
        children: recommendedVideos.entries.map<Widget>((entry) {
          String chapter = entry.key;
          List<dynamic> videos = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chapter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Column(
                children: videos.map<Widget>((video) {
                  return ListTile(
                    title: Text(video['videoTitle']),
                    subtitle: GestureDetector(
                      child: Text(
                        video['videoLink'],
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      /*
                      onTap: () async {
                        if (await canLaunch(video['videoLink'])) {
                          await launch(video['videoLink']);
                        } else {
                          throw 'Could not launch ${video['videoLink']}';
                        }
                      },*/
                      onTap: () async {
  if (await canLaunch(video['videoLink'])) {
    await launch(video['videoLink']);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Impossible d\'ouvrir le lien ${video['videoLink']}'),
      ),
    );
  }
},

                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}*/
