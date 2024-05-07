import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thc/utils/navigator.dart';

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
      navigator.showSnackBar(SnackBar(content: Text('$text event added!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theGoodStuff = <Widget>[
      TextFormField(
        controller: _event,
        decoration: const InputDecoration(labelText: 'Event Title'),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the event title.';
          }
          return null;
        },
      ),
      TextFormField(
        controller: _startDate,
        decoration: const InputDecoration(
          labelText: 'Start Date',
          icon: Icon(Icons.calendar_today_rounded),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the event start date.';
          }
          return null;
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
          icon: Icon(Icons.calendar_today_rounded),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the event end date.';
          }
          return null;
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
          icon: Icon(Icons.access_time_rounded),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the event start time.';
          }
          return null;
        },
        onTap: () async {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

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
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the event end time.';
          }
          return null;
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
        },
        child: const Text('Submit'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: theGoodStuff,
            ),
          ),
        ),
      ),
    );
  }
}
