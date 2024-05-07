import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
// import 'package:googleapis/calendar/v3.dart' as calendar;
// import 'package:googleapis_auth/auth_io.dart' as auth;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // Set the app's primary theme color
      ),
      title: 'Event Form',
      home: const MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // A key for managing the form
  final TextEditingController _event = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();

  void _submitForm(String mytext) {
    final text = mytext;
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$text event added!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Associate the form key with this Form widget
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _event,
                  decoration: const InputDecoration(labelText: 'Event Title'),
                  validator: (value) {
                    // Validation function for the event title field
                    if (value!.isEmpty) {
                      return 'Please enter the event title.'; // Return an error message if the event title is empty
                    }
                    return null; // Return null if the event title is valid
                  },
                ),
                TextFormField(
                  controller: _startDate,
                  decoration: const InputDecoration(
                    labelText: 'Start Date',
                    icon: Icon(Icons.calendar_today_rounded),
                  ), // Label for the event start date field
                  validator: (value) {
                    // Validation function for the event start date field
                    if (value!.isEmpty) {
                      return 'Please enter the event start date.'; // Return an error message if the event start date is empty
                    }
                    // You can add more complex validation logic here
                    return null; // Return null if the event start date is valid
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2035));

                    if (picked != null) {
                      setState(() {
                        _startDate.text = DateFormat('yyyy-MM-dd').format(picked);
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: _endDate,
                  decoration: const InputDecoration(
                      labelText: 'End Date',
                      icon: Icon(
                        Icons.calendar_today_rounded,
                      )), // Label for the event end date field
                  validator: (value) {
                    // Validation function for the event end date field
                    if (value!.isEmpty) {
                      return 'Please enter the event end date.'; // Return an error message if the event end date is empty
                    }
                    // You can add more complex validation logic here
                    return null; // Return null if the event end date is valid
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2035));

                    if (picked != null) {
                      setState(() {
                        _endDate.text = DateFormat('yyyy-MM-dd').format(picked);
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: _startTime,
                  decoration: const InputDecoration(
                      labelText: 'Start Time',
                      icon: Icon(
                        Icons.access_time_rounded,
                      )), // Label for the event start time field
                  validator: (value) {
                    // Validation function for the event start time field
                    if (value!.isEmpty) {
                      return 'Please enter the event start time.'; // Return an error message if the start time is empty
                    }
                    // You can add more complex validation logic here
                    return null; // Return null if the start time is valid
                  },
                  onTap: () async {
                    final TimeOfDay? picked =
                        await showTimePicker(context: context, initialTime: TimeOfDay.now());

                    if (picked != null) {
                      setState(() {
                        _startTime.text = picked.format(context);
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: _endTime,
                  decoration: const InputDecoration(
                      labelText: 'End Time',
                      icon: Icon(
                        Icons.access_time_sharp,
                      )), // Label for the event end time field
                  validator: (value) {
                    // Validation function for the event end time field
                    if (value!.isEmpty) {
                      return 'Please enter the event end time.'; // Return an error message if the event end time is empty
                    }
                    // You can add more complex validation logic here
                    return null; // Return null if the event end time is valid
                  },
                  onTap: () async {
                    final TimeOfDay? picked =
                        await showTimePicker(context: context, initialTime: TimeOfDay.now());

                    if (picked != null) {
                      setState(() {
                        _endTime.text = picked.format(context);
                      });
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    final String mtext = _event.text;
                    _submitForm(mtext);
                  }, // _submitForm, // Call the _submitForm function when the button is pressed
                  child: const Text('Submit'), // Text on the button
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';
// // import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:googleapis/calendar/v3.dart' as calendar;
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:http/http.dart' as http;
// import 'schedule_creds.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Google Calendar Example',
//       home: CalendarScreen(),
//     );
//   }
// }

// class CalendarScreen extends StatefulWidget {
//   const CalendarScreen({super.key});

//   @override
//   State<CalendarScreen> createState() => _CalendarScreenState();
// }

// class _CalendarScreenState extends State<CalendarScreen> {
//   @override
//   Widget build(BuildContext context) => throw UnimplementedError();
// }
