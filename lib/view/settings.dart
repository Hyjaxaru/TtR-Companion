import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';
import 'package:watch_it/watch_it.dart';

class SettingsView extends WatchingWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorScheme.of(context).surfaceContainer,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            backgroundColor: ColorScheme.of(context).surfaceContainer,
            centerTitle: false,
            title: Text('Settings', style: TextStyle(fontFamily: 'RobotoSlab')),
          ),

          SliverGroupedList(
            heading: const GroupedListHeader('Theme'),
            children: [
              GroupedListTile(
                title: const Text('Theme Mode'),
                leading: const Icon(Icons.brightness_auto_rounded),
                trailing: DropdownButton<String>(
                  value: watchPropertyValue((SettingsModel m) => m.appThemeMode),
                  hint: const Text('Select Theme'),
                  onChanged: (value) => di<SettingsModel>().appThemeMode = value!,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'light',
                      child: Text('Light'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'dark',
                      child: Text('Dark'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'system',
                      child: Text('System'),
                    ),
                  ],
                ),
              ),
              
              if (Platform.isAndroid)
                GroupedListTile(
                  title: const Text('Use Device Colours'),
                  subtitle: const Text('Use your device\'s colour palette'),
                  leading: Icon(
                    Icons.palette_rounded,
                    color: ColorScheme.of(context).primary
                  ),
                  trailing: Switch(
                    value: watchPropertyValue((SettingsModel m) => m.useDeviceColorScheme),
                    onChanged: (value) => di<SettingsModel>().useDeviceColorScheme = value,
                  ),
                ),
            ]
          ),

          SliverGroupedList(
            heading: const GroupedListHeader('Reset'),
            children: [
              GroupedListTile(
                title: Text(
                  'Delete Game History',
                  style: TextStyle(color: ColorScheme.of(context).error)
                ),
                subtitle: const Text('Delete all your previous games'),
                leading: Icon(Icons.delete_rounded, color: ColorScheme.of(context).error),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),

              GroupedListTile(
                title: const Text('Reset Settings'),
                leading: Icon(Icons.restore_rounded, color: ColorScheme.of(context).error),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),
            ]
          ),

          SliverGroupedList(
            heading: const GroupedListHeader('About'),
            children: [
              GroupedListTile(
                title: const Text('TtR Companion'),
                subtitle: const Text('v0.1-alpha'),
                leading: const Icon(Icons.info_rounded),
                trailing: const Icon(Icons.arrow_forward_rounded),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationIcon: FlutterLogo(),
                  applicationName: 'TtR Companion',
                  applicationVersion: 'v0.1-alpha',
                  children: [
                    Text('For the love of the game!'),
                    Text('Open Source')
                  ],
                ),
              ),

              GroupedListTile(
                title: const Text('Contribute'),
                subtitle: const Text('Help make this app better!'),
                leading: const Icon(Icons.commit),
                trailing: const Icon(Icons.open_in_new_rounded),
              ),
            ]
          ),
        ],
      )
    );
  }
}