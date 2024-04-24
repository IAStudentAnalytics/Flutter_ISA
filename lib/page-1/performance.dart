import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package
import 'dart:math';
import 'package:pim/page-1/rec.dart';
import 'package:spider_chart/spider_chart.dart';

class Performance extends StatelessWidget {
  const Performance({Key? key}) : super(key: key);

  // Sample data for radar chart

  @override
  Widget build(BuildContext context) {
    final List<double> performanceData = [
      80,
      90,
      70,
      85,
      75
    ]; // Sample percentages for 5 chapters
    return Scaffold(
      body: Container(
        width: double
            .infinity, // Permet au conteneur de prendre toute la largeur de l'écran
        height: double
            .infinity, // Permet au conteneur de prendre toute la hauteur de l'écran
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 415,
                height: 343,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFF92626), Color(0x00A15656)],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -90,
              top: -106,
              child: Container(
                width: 272,
                height: 263,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 63,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: ShapeDecoration(
                          color: Color(0x72D7EBEA),
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 72,
                      top: 0,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: ShapeDecoration(
                          color: Color(0x68DAF4F2),
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 25,
              top: 160,
              child: Container(
                width: 300,
                height: 300,
                child: Stack(
                  children: [
                    // SpiderChart widget goes here
                    SpiderChart(
                      data: [70, 50, 80, 70, 40],
                      maxValue: 100,
                      colors: [
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.yellow,
                        Colors.indigo,
                      ],
                    ),
                    // Positioned points with text labels
                  ],
                ),
              ),
            ),
            Positioned(
              left: 80, // Adjust position as needed
              top: 450, // Adjust position as needed
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Chapter 1",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 130, // Adjust position as needed
              top: 450, // Adjust position as needed
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Chapter 2",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 180, // Adjust position as needed
              top: 450, // Adjust position as needed
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Chapter 3",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 230, // Adjust position as needed
              top: 450, // Adjust position as needed
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Chapter 4",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 280, // Adjust position as needed
              top: 450, // Adjust position as needed
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Chapter 5",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              top: 150,
              child: SizedBox(
                width: 95,
                child: Text(
                  'Performance :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 500,
              child: SizedBox(
                width: 114,
                child: Text(
                  'Recommendation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 25,
              top: 526,
              child: Container(
                width: 325,
                height: 184,
                decoration: ShapeDecoration(
                  color: Color(0xB5D2D2D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ),
            // Navigation button to RecommendedVideosPage
            Positioned(
              left: 25,
              top: 726, // Adjusted based on the layout
              child: SizedBox(
                width: 325, // Match the width of the container above
                height: 50, // Height of the button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RecommendedVideosPage()),
                    );
                  },
                  child: Text('View Recommended Videos'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Button color
                    onPrimary: Colors.white, // Text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
