import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  // initialise storage
  await GetStorage.init();

  //GetStorage().erase();

  // run the app
  runApp(const TtRApp());
}
