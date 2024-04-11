import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thc/firebase/user.dart';
import 'package:thc/home/profile/account/account_field.dart';
import 'package:thc/home/profile/profile.dart';
import 'package:thc/utils/navigator.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  void initState() {
    AccountField.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final saveButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FilledButton(
        onPressed: context.watch<AccountFields>().hasChanges
            ? () {
                context.read<AccountFields>().save(AccountField.updatedUser);
                setState(AccountField.reset);
              }
            : null,
        child: const Text('save changes'),
      ),
    );

    return PopScope(
      onPopInvoked: (_) => context.read<AccountFields>().emit(user!),
      child: Scaffold(
        appBar: AppBar(title: const Text('Account')),
        body: ProfileListView(
          itemCount: 4,
          itemBuilder: (_, index) => switch (index) {
            0 => Column(children: [...AccountField.values, saveButton]),
            1 => const ListTile(
                leading: Icon(Icons.lock_outline),
                title: Text('change password'),
                // onTap: () {},
              ),
            2 => ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('sign out'),
                onTap: () => navigator.showDialog(
                  builder: (_) => AlertDialog.adaptive(
                    title: const Text('sign out'),
                    content: const Text(
                      'Are you sure you want to sign out?\n'
                      "You'll need to enter your email & password to sign back in.",
                    ),
                    actions: [
                      ElevatedButton(onPressed: navigator.pop, child: const Text('back')),
                      ElevatedButton(onPressed: navigator.logout, child: const Text('sign out')),
                    ],
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ),
            _ => const ListTile(
                leading: Icon(Icons.person_off_outlined),
                title: Text('close account'),
                // onTap: () {},
              ),
          },
        ),
      ),
    );
  }
}