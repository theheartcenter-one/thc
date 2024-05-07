import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  static const queryString =
      'GET https://accounts.google.com/o/oauth2/v2/auth?response_type=code&state=state_parameter_passthrough_value&scope=https%3A//www.googleapis.com/auth/drive.file&redirect_uri=https%3A//oauth2.example.com/code&prompt=consent&include_granted_scopes=true';

  // final String _accessToken = 'YOUR_ACCESS_TOKEN'; // Replace with actual access token

  Future<void> _createEvent() async {
    final getUrl = Uri.parse(queryString);

    final getResponse = await http.get(
      getUrl,
      headers: {
        'client_id': 'clientID',
        'client_secret': 'clientSECRET',
      },
    );
    if (getResponse.statusCode == 200) {
      final jsonResponse = jsonDecode(getResponse.body) as Map<String, dynamic>;
      // final itemCount = jsonResponse['totalItems'];
      // ignore: avoid_print
      print(jsonResponse);
      // print('Number of books about Marvel: $itemCount.');
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${getResponse.statusCode}.');
    }

    // final url = Uri.parse('https://www.googleapis.com/calendar/v3/calendars/primary/events');
    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Authorization': 'Bearer $_accessToken',
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode({
    //     'summary': 'Flutter Event',
    //     'description': 'A test event created from a Flutter app',
    //     'start': {'dateTime': DateTime.now().toUtc().add(Duration(hours: 1)).toIso8601String()},
    //     'end': {'dateTime': DateTime.now().toUtc().add(Duration(hours: 2)).toIso8601String()},
    //   }),
    // );

    // if (response.statusCode == 200) {
    //   print('Event created successfully.');
    // } else {
    //   print('Failed to create event. Status code: ${response.statusCode}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Center(
        child: ElevatedButton(
          onPressed: _createEvent,
          child: const Text('Create Event'),
        ),
      ),
    );
  }
}
