// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


// class VideoRecommendationsPage extends StatefulWidget {
//   @override
//   _VideoRecommendationsPageState createState() => _VideoRecommendationsPageState();
// }

// class _VideoRecommendationsPageState extends State<VideoRecommendationsPage> {
//   Map<String, dynamic> recommendedVideos = {};

//   Future<void> fetchRecommendedVideos() async {
//     final String testId = '66259a8177b0e5198289f765';
//     final String studentId = '65df009a796124616d1ecdce';

//     final response = await http.get(Uri.parse('http://127.0.0.1:60430/note/rec/$testId/$studentId'));

//     if (response.statusCode == 200) {
//       setState(() {
//         recommendedVideos = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load recommended videos');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchRecommendedVideos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('YouTube Recommendations'),
//       ),
//       body: recommendedVideos.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: recommendedVideos.length,
//               itemBuilder: (context, index) {
//                 final chapitre = recommendedVideos.keys.toList()[index];
//                 final videos = recommendedVideos[chapitre];

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                       child: Text(
//                         'Videos recommandées pour le chapitre "$chapitre":',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Column(
//                       children: videos.map<Widget>((video) {
//                         return ListTile(
//                           title: Text(video['videoTitle']),
//                           subtitle: Text(video['videoLink']),
//                           trailing: Text('${video['viewCount']} vues'),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 );
//               },
//             ),
//     );
//   }
// }
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class VideoRecommendationsPage extends StatefulWidget {
  @override
  _VideoRecommendationsPageState createState() => _VideoRecommendationsPageState();
}

class _VideoRecommendationsPageState extends State<VideoRecommendationsPage> {
  Map<String, List<Map<String, String>>> recommendedVideos = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Future<void> fetchData() async {
  //   final response = await http.get('http://localhost:3000/recommend/ID_DU_TEST/ID_DE_L_ETUDIANT');
  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     setState(() {
  //       recommendedVideos = responseData['recommendedVideos'];
  //     });
  //   } else {
  //     print('Failed to load recommended videos');
  //   }
  // }
  
  Future<void> fetchData() async {
    final String testId = '66259a8177b0e5198289f765';
    final String studentId = '65df009a796124616d1ecdce';

    final response = await http.get(Uri.parse('http://127.0.0.1:60430/note/rec/$testId/$studentId'));

    if (response.statusCode == 200) {
      setState(() {
        recommendedVideos = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load recommended videos');
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Videos'),
      ),
      body: ListView.builder(
        itemCount: recommendedVideos.length,
        itemBuilder: (context, index) {
          final chapitre = recommendedVideos.keys.elementAt(index);
          final videos = recommendedVideos[chapitre]?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chapitre,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return ListTile(
                    title: GestureDetector(
                      onTap: () => _launchURL(video['videoLink']!),
                      child: Text(video['videoTitle']!),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';




class RecommendedVideosPage extends StatefulWidget {
  @override
  _RecommendedVideosPageState createState() => _RecommendedVideosPageState();
}

class _RecommendedVideosPageState extends State<RecommendedVideosPage> {
  Map<String, dynamic> recommendedVideos = {};

  @override
  void initState() {
    super.initState();
    fetchRecommendedVideos();
  }

  Future<void> fetchRecommendedVideos() async {
      final String testId = '66259a8177b0e5198289f765';
    final String studentId = '65df009a796124616d1ecdce';

    final response = await http.get(Uri.parse('http://127.0.0.1:60430/note/rec/$testId/$studentId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recommendedVideos = data['recommendedVideos'];
      });
    } else {
      throw Exception('Failed to load recommended videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vidéos Recommandées'),
      ),
      body: ListView.builder(
        itemCount: recommendedVideos.length,
        itemBuilder: (context, index) {
          String chapter = recommendedVideos.keys.elementAt(index);
          return ExpansionTile(
            title: Text(chapter),
            children: recommendedVideos[chapter].map<Widget>((video) {
              return ListTile(
  title: Text(video['videoTitle']),
  subtitle: GestureDetector(
    child: Text.rich(
      TextSpan(
        text: video['videoLink'],
        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
      ),
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
          );
        },
      ),
    );
  }
}
*/
//Code mrigeeeeeeeeeeel
/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RecommendedVideosPage extends StatefulWidget {
  @override
  _RecommendedVideosPageState createState() => _RecommendedVideosPageState();
}

class _RecommendedVideosPageState extends State<RecommendedVideosPage> {
  Map<String, dynamic> recommendedVideos = {};

  @override
  void initState() {
    super.initState();
    fetchRecommendedVideos();
  }

  Future<void> fetchRecommendedVideos() async {
    final String testId = '66259a8177b0e5198289f765';
    final String studentId = '65df009a796124616d1ecdce';

    final response = await http.get(Uri.parse('http://127.0.0.1:60430/note/rec/$testId/$studentId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recommendedVideos = data['recommendedVideos'];
      });
    } else {
      throw Exception('Failed to load recommended videos');
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
*/


//lib/pages/recommended_videos_page.dart
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
    final String testId = '66259a8177b0e5198289f765';
    final String studentId = '65df009a796124616d1ecdce';

    try {
      final videos = await _videoService.fetchRecommendedVideos(testId, studentId);
      setState(() {
        recommendedVideos = videos;
      });
    } catch (e) {
      // Gérer l'erreur ici
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