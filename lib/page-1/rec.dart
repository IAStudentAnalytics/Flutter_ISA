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
    
    final String testId = '6627e8fd25cc4f362fbf3bd3';
    final String studentId = '65defb8f796124616d1ecdc2';
    

    try {
      final videos = await _videoService.fetchRecommendedVideos(testId, studentId);
      setState(() {
        recommendedVideos = videos;
      });
    } catch (e) {
    
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
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        if (await canLaunch(video['videoLink'])) {
                          await launch(video['videoLink']);
                        } else {
                          throw 'Could not launch ${video['videoLink']}';
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


