import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thc/firebase/firebase.dart';
import 'package:thc/home/users/src/all_users.dart';
import 'package:thc/utils/navigator.dart';
import 'package:thc/utils/style_text.dart';
import 'package:thc/utils/theme.dart';

class ScheduleEditor extends StatefulWidget {
  const ScheduleEditor({super.key});

  @override
  State<ScheduleEditor> createState() => _ScheduleEditorState();
}

class _ScheduleEditorState extends State<ScheduleEditor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _event = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();

  Director? director;

  void submit() {
    if (_formKey.currentState!.validate()) {
      navigator.showSnackBar(SnackBar(content: Text('${_event.text} event added!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final formContents = <Widget>[
      DirectorDropdown(
        onSaved: (value) => setState(() => director = value),
        validator: (value) => value == null ? '[error message]' : null,
      ),
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
            lastDate: DateTime(2035),
          );

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
          icon: Icon(Icons.access_time_sharp),
        ),
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
        onPressed: submit,
        child: const Text('Submit'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Create Event Form')),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(children: formContents),
        ),
      ),
    );
  }
}

class DirectorDropdown extends FormField<Director> {
  DirectorDropdown({
    super.key,
    super.autovalidateMode,
    super.initialValue,
    super.onSaved,
    super.validator,
  }) : super(
          restorationId: 'director dropdown',
          builder: (field) {
            final options = [
              for (final user in ThcUsers.of(field.context))
                if (user is Director)
                  DropdownMenuEntry(
                    value: user,
                    label: '${user.name} (${user.firestoreId})',
                    labelWidget: Text(user.name),
                    trailingIcon: Text(
                      user.firestoreId,
                      style: StyleText(
                        size: 12,
                        color: ThcColors.of(field.context).onSurface.withOpacity(0.5),
                      ),
                    ),
                  ),
            ];

            return DropdownMenu(
              label: const Text('Director name'),
              dropdownMenuEntries: options,
              expandedInsets: EdgeInsets.zero,
              enableFilter: true,
              onSelected: onSaved,
              errorText: field.errorText,
            );
          },
        );
}
