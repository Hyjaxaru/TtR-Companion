import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_it/watch_it.dart';

class TtRApp extends StatefulWidget {
  const TtRApp({super.key});

  @override
  State<TtRApp> createState() => _TtRAppState();
}

class _TtRAppState extends State<TtRApp> {
  GetStorage settingsBox = GetStorage('settings');
  late Function? settingsListen;

  ThemeMode get themeMode {
    return switch (settingsBox.read('appThemeMode') ?? 'system') {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system
    };
  }

  ColorScheme colorScheme(ColorScheme? dynamic, Brightness brightness) {
    final bool useDynamic = settingsBox.read("appUseDeviceColorScheme") ?? false;
    final ColorScheme defaultScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.expressive
    );
    return useDynamic ? dynamic ?? defaultScheme : defaultScheme;
  }

  @override
  void initState() {
    super.initState();

    // register the app model
    di.registerSingleton<TtRAppModel>(TtRAppModel());
    di.registerSingleton<SettingsModel>(SettingsModel());

    // check for updates in the settings storage box
    settingsListen = settingsBox.listen(() => setState(() {}));
  }

  @override
  void dispose() {
    settingsListen?.call();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Ticket to Ride Companion',
          debugShowCheckedModeBanner: false,
          home: TtRHome(),
          theme: ThemeData.from(
            colorScheme: colorScheme(lightDynamic, Brightness.light),
          ),
          darkTheme: ThemeData.from(
            colorScheme: colorScheme(darkDynamic, Brightness.dark)
          ),
          themeMode: themeMode
        );
      }
    );
  }
}