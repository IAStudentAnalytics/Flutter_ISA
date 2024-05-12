import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pim/models/CoursR.dart';
import 'package:pim/page-1/side_menu.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  late Future<List<CoursR>> coursList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    coursList = CoursService.fetchCours();
    coursList.then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void deleteCours(String id) async {
    try {
      await CoursService.deleteCours(id);
      setState(() {
        coursList = CoursService.fetchCours();
      });
    } catch (error) {
      print('Error deleting course: $error');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Error: Unable to open URL $pdfUrl');
    }
  }

  Map<String, List<CoursR>> groupCoursByNomCoursR(List<CoursR> coursList) {
    Map<String, List<CoursR>> groupedCours = {};

    for (var cours in coursList) {
      if (!groupedCours.containsKey(cours.nomCoursR)) {
        groupedCours[cours.nomCoursR] = [];
      }
      groupedCours[cours.nomCoursR]!.add(cours);
    }

    return groupedCours;
  }

  Map<String, int> countCoursByChapter(Map<String, List<CoursR>> coursMap) {
    Map<String, int> countMap = {};
    coursMap.forEach((key, value) {
      countMap[key] = value.length;
    });
    return countMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('Courses'),
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 237, 46, 46),
              Color(0xFFF6F1FB),
            ],
            stops: [0, 1],
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : FutureBuilder<List<CoursR>>(
                future: coursList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('error : ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final coursMap = groupCoursByNomCoursR(snapshot.data!);
                    return GridView.builder(
                      padding: EdgeInsets.all(20.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: kIsWeb ? 2 : 1, // Nombre de colonnes
                        childAspectRatio: kIsWeb
                            ? 6 / 2
                            : 5 / 2, // Ratio largeur/hauteur des cellules
                        crossAxisSpacing:
                            kIsWeb ? 20.0 : 10.0, // Espace entre les colonnes
                        mainAxisSpacing:
                            kIsWeb ? 20.0 : 10.0, // Espace entre les lignes
                      ),
                      itemCount: coursMap.length,
                      itemBuilder: (context, index) {
                        final key = coursMap.keys.elementAt(index);
                        return buildGroupedContainer(key, coursMap[key]!);
                      },
                    );

                  } else {
                    return Center(child: Text('No courses found'));
                  }
                },
              ),
      ),
    );
  }

  Widget buildGroupedContainer(String key, List<CoursR> coursList) {
    Map<String, int> countMap =
        countCoursByChapter(groupCoursByNomCoursR(coursList));
    int numberOfCours = countMap[key] ?? 0;

    return GestureDetector(
      onTap: () {
showDialog(
  context: context,
  builder: (BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(key),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0), // Ajustez les marges intérieures
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Activez le défilement vertical
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: coursList
                  .map((cours) => ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.picture_as_pdf),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  openPdf(cours.pdff);
                                },
                                child: Text(cours.description),
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton.icon(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirmation'),
                                  content: Text(
                                      'Are you sure you want to delete this course?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Confirm'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        deleteCours(cours.id);
                                        setState(() {
                                          coursList.removeWhere(
                                              (element) =>
                                                  element.id == cours.id);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete, size: 20.0),
                          label: Text(
                            'Delete',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Color.fromARGB(255, 142, 1, 1),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  },
);

      },
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 175, 12, 12),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'assets/jaa.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Chapitre $key',
                        style: MediaQuery.of(context).size.width < 600
                            ? TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                              )
                            : TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Number of courses : $numberOfCours',
                       style: MediaQuery.of(context).size.width < 600
                            ? TextStyle(
                                 color: Colors.black,
                               fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30,
                              )
                            : TextStyle(
                                 color: Colors.black,
                               fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                              ),
                     
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
