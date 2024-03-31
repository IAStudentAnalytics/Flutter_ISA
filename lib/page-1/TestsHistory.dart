import 'package:flutter/material.dart';
import 'package:pim/models/test.dart';
import 'package:pim/page-1/side_menu.dart'; // Import the Test model

class TestsHistory extends StatefulWidget {
  final List<Test> tests;

  TestsHistory({required this.tests});

  @override
  _TestsHistoryState createState() => _TestsHistoryState();
}

class _TestsHistoryState extends State<TestsHistory> {
  List<Test> _sortedTests = [];

  @override
  void initState() {
    super.initState();
    _sortedTests = List.from(widget.tests); // Initialize sortedTests with the provided tests
  }

  void _sortByAlphabet() {
    setState(() {
      _sortedTests.sort((a, b) => a.title.compareTo(b.title));
    });
  }

  void _sortByDate() {
    setState(() {
      _sortedTests.sort((a, b) => a.creationDate.compareTo(b.creationDate));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests History'),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffdf0b0b), Color(0x00f6f1fb)],
                stops: [0, 1],
              ),
            ),
          ),
          Positioned.fill(
                child: Opacity(
                  opacity: 0.15,
                  child: Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child: Image.asset(
                        'assets/page-1/images/n-removebg-preview-5.png',
                        fit: BoxFit.cover, // Adjust how the image should be fitted
                      ),
                    ),
                  ),
                ),
              ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                  child: ElevatedButton(
                    onPressed: _sortByAlphabet,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Sort by Alphabet'),
                    ),
                  ),
                  ),
                  SizedBox(width: 2),
                  Flexible(
                  child: ElevatedButton(
                    onPressed: _sortByDate,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('Sort by Date'),
                    ),
                  ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _sortedTests.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text(_sortedTests[index].title),
                        subtitle: Text(_sortedTests[index].creationDate.toString()),
                        // Add more details to display as needed
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}),
    );
  }
  Widget buildMenuButton(BuildContext context, double fem, String text, IconData icon, String route) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.0 * fem, vertical: 12.0 * fem),
        // Adjust button size according to screen size
        minimumSize: Size(150 * fem, 50 * fem),
      ),
    );
  }
}