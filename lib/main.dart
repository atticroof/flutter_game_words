import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_words/storage/_storage.dart';
import 'package:game_words/storage/store_data.dart';
import 'package:soundpool/soundpool.dart';

import 'facade/facade.dart';

final storage = WGStoreDataImpl();
final states = WGStoreStates();
final facade = Facade(storage, states);

void _run() async {
  await Future.delayed(const Duration(microseconds: 13));
  await facade.factory.flow.makeFlowStartup().run();
  facade.factory.flow.makeFlowMain().run();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(MaterialApp(home: const Scaffold(backgroundColor: Colors.lime), navigatorKey: facade.navigator.navigatorKey));
  _run();
}
