import 'package:flutter/material.dart';
import 'package:game_words/factory/factory.dart';
import 'package:game_words/framework/_framework.dart';
import 'package:game_words/storage/store_data.dart';
import 'package:game_words/storage/store_states.dart';
import 'package:soundpool/soundpool.dart';

class Facade {
  Facade(this._storeData, this.statesManager);

  final WGStoreDataImpl _storeData;

  WGStoreDataManager get dataManager => _storeData;

  WGStoreStates statesManager;

  late final factory = Factory(this);

  final navigator = XRouteNavigator(routeBuilder: (widgetBuilder) => MaterialPageRoute(builder: widgetBuilder));

  final soundpool = Soundpool.fromOptions();
}
