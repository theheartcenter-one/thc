import 'package:flutter/material.dart';
import 'package:thc/firebase/firebase.dart';
import 'package:thc/utils/navigator.dart';
import 'package:thc/utils/theme.dart';
import 'package:thc/utils/widgets/error_dialog.dart';

class Permissions extends StatelessWidget {
  const Permissions({super.key, required this.user});
  final Json user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user['name'])),
      body: RadioGroup(user: user),
    );
  }
}

class RadioGroup extends StatefulWidget {
  const RadioGroup({super.key, required this.user});
  final Json user;

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  late UserType selected = UserType.fromJson(widget.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'User Permissions',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        for (final userType in UserType.values)
          RadioListTile<UserType>(
            title: Text('$userType'),
            subtitle: Text(
              switch (userType) {
                UserType.participant => 'Participants can do 123',
                UserType.director => 'Directors can do 456',
                UserType.admin => 'Admin can do 789',
              },
              style: const TextStyle(color: ThcColors.gray),
            ),
            value: userType,
            groupValue: selected,
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() => selected = newValue);
                updatePermissions(widget.user['id'], newValue);
              }
            },
          ),
      ],
    );
  }

  Future<void> updatePermissions(String userId, UserType newType) async {
    try {
      await Firestore.users.doc(userId).update({'type': '$newType'});
    } catch (e) {
      navigator.showDialog(ErrorDialog('Error updating permissions: $e'));
    }
  }
}
