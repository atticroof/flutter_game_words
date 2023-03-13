import 'package:flutter/widgets.dart';
import 'package:game_words/storage/store_data.dart';

typedef XPageState<T> = T Function();

abstract class XStatefulPage<T> extends XPage {
  const XStatefulPage({super.key, required super.data, required this.getState});

  final XPageState<T> getState;
}

abstract class XPage extends StatelessWidget {
  const XPage({super.key, required this.data});

  final WGStoreData data;
}
