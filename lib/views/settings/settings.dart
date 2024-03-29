import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thc/models/bloc.dart';
import 'package:thc/models/local_storage.dart';
import 'package:thc/models/navigation.dart';
import 'package:thc/models/user.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Dark theme?', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const _ThemePicker(),
            if (userType.isAdmin) ...const [
              SizedBox(height: 50),
              NavBarSwitch(StorageKeys.adminWatchLive),
              NavBarSwitch(StorageKeys.adminStream),
            ],
          ],
        ),
      ),
    );
  }
}

class NavBarSwitch extends StatefulWidget {
  const NavBarSwitch(this.storageKey, {super.key});
  final StorageKeys storageKey;

  @override
  State<NavBarSwitch> createState() => _NavBarSwitchState();
}

class _NavBarSwitchState extends State<NavBarSwitch> {
  late bool value = widget.storageKey();
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: Text(switch (widget.storageKey) {
        StorageKeys.adminWatchLive => 'show "watch live"',
        StorageKeys.adminStream || _ => 'show "stream"',
      }),
      value: value,
      onChanged: (newValue) {
        setState(() => value = newValue);
        widget.storageKey.save(newValue);
        context.read<NavBarIndex>().refresh();
      },
    );
  }
}

class AppTheme extends Cubit<ThemeMode> {
  AppTheme() : super(StorageKeys.themeMode());

  void newThemeMode(ThemeMode newTheme) {
    StorageKeys.themeMode.save(newTheme.index);
    emit(newTheme);
  }
}

class _ThemePicker extends StatelessWidget {
  const _ThemePicker();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<AppTheme>().state;
    return SegmentedButton<ThemeMode>(
      showSelectedIcon: false,
      segments: [
        for (final value in ThemeMode.values)
          ButtonSegment(
            value: value,
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(value.name),
            ),
          ),
      ],
      selected: {themeMode},
      onSelectionChanged: (selection) => context.read<AppTheme>().newThemeMode(selection.first),
    );
  }
}
