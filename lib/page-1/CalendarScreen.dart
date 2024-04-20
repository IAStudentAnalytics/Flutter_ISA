import 'package:flutter/material.dart';
import 'package:pim/page-1/side_menu.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  final Function(int) onMenuItemClicked;

  const CalendarScreen({required this.onMenuItemClicked});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late List<Meeting> _meetings;

  @override
  void initState() {
    super.initState();
    _meetings = _getDataSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('Calendar'),
      ),
      body: Stack(
        children: [
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
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
          SfCalendar(
            view: CalendarView.month,showDatePickerButton: true,
            dataSource: MeetingDataSource(_meetings),
            monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              monthCellStyle: MonthCellStyle(backgroundColor: Colors.white60),
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            blackoutDatesTextStyle: TextStyle(backgroundColor: Colors.black38),
            onTap: (CalendarTapDetails details) {
              if (details.targetElement == CalendarElement.calendarCell) {
                _showEventCreationDialog(details.date!);
              }
            },
          ),
        ],
      ),
      drawer: SideMenu(onMenuItemClicked: widget.onMenuItemClicked),
    );
  }

  void _showEventCreationDialog(DateTime date) {
    TextEditingController eventNameController = TextEditingController();
    DateTime selectedDate = date;
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: eventNameController,
                decoration: InputDecoration(labelText: 'Event Name'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)), // Allow selecting dates within the next year
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text('Select Date'),
                  ),
                  Text(selectedDate.toString()),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Text('Select Time'),
                  ),
                  Text(selectedTime.format(context)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addEvent(eventNameController.text, selectedDate, selectedTime);
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _addEvent(String eventName, DateTime date, TimeOfDay time) {
    final DateTime eventDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final newEvent = Meeting(
      eventName,
      eventDateTime,
      eventDateTime.add(const Duration(hours: 1)),
      Colors.blue,
      false,
    );
    setState(() {
      _meetings.add(newEvent);
    });
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Meeting(
        'Conference',
        startTime,
        endTime,
        const Color(0xFF0F8644),
        false,
      ),
    );
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
