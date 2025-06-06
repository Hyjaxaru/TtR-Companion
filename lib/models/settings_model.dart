import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SettingsModel extends ChangeNotifier {
  /// local storage using [GetStorage]
  final GetStorage storage;

  /// The settings model 😎 
  SettingsModel() : storage = GetStorage('settings');

  /// Writes a new value to a setting, and updates listeners
  void updateSetting(String key, dynamic value) {
    storage.write(key, value);
    notifyListeners();
  }

  /// The device theme
  String get appThemeMode => storage.read('appThemeMode') ?? 'system';
  set appThemeMode(String value) => updateSetting('appThemeMode', value);

  /// App uses dynamic color
  bool get useDeviceColorScheme => storage.read('useDeviceColorScheme') ?? false;
  set useDeviceColorScheme(bool value) => updateSetting('useDeviceColorScheme', value);
}