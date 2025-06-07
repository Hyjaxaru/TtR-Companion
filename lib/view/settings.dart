import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';
import 'package:watch_it/watch_it.dart';

class SettingsView extends WatchingWidget {
  const SettingsView({super.key});

  static const Widget _devIcon = Tooltip(
    message: 'Under Construction',
    child: Icon(Icons.construction_rounded)
  );

  @override
  Widget build(BuildContext context) {
    final appThemeMode =
      watchPropertyValue((SettingsModel m) => m.appThemeMode);
    final useDeviceColorScheme =
      watchPropertyValue((SettingsModel m) => m.useDeviceColorScheme);

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
                leading: const Icon(

                  Icons.brightness_auto_rounded
                ),
                trailing: DropdownButton<String>(
                  value: appThemeMode,
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
              
              if (Platform.isAndroid || useDeviceColorScheme)
                GroupedListTile(
                  title: const Text('Use Device Colours'),
                  subtitle: const Text('Use your device\'s colour palette'),
                  leading: Icon(
                    Icons.palette_rounded,
                    color: useDeviceColorScheme ? ColorScheme.of(context).primary : null
                  ),
                  trailing: Switch(
                    value: useDeviceColorScheme,
                    onChanged: (value) => di<SettingsModel>().useDeviceColorScheme = Platform.isAndroid && value,
                  ),
                ),
              
              GroupedListTile(
                enabled: !useDeviceColorScheme,
                title: const Text('Theme Colour'),
                subtitle: useDeviceColorScheme
                    ? const Text('Following your device settings')
                    : const Text('Choose a theme colour that the app will follow'),
                leading: Icon(
                  Icons.palette_rounded,
                  color: !useDeviceColorScheme ? ColorScheme.of(context).primary : null
                ),
                trailing: _devIcon,
              ),

              GroupedListTile(
                title: const Text('Colour Style'),
                subtitle: const Text('Choose the colour scheme style'),
                leading: Icon(
                  Icons.palette_rounded,
                  color: ColorScheme.of(context).tertiary
                ),
                trailing: _devIcon,
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
                trailing: _devIcon,
              ),

              GroupedListTile(
                title: const Text('Reset Settings'),
                leading: Icon(Icons.restore_rounded, color: ColorScheme.of(context).error),
                trailing: _devIcon,
              ),
            ]
          ),

          SliverGroupedList(
            heading: const GroupedListHeader('About'),
            children: [
              GroupedListTile(
                title: const Text('TtR Companion'),
                subtitle: const Text('development'),
                leading: const Icon(Icons.info_rounded),
                trailing: const Icon(Icons.arrow_forward_rounded),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationIcon: FlutterLogo(),
                  applicationName: 'TtR Companion',
                  applicationVersion: 'development',
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
                trailing: _devIcon
              ),
            ]
          ),
        ],
      )
    );
  }
}