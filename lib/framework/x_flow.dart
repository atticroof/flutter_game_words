import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:game_words/facade/facade.dart';

abstract class XFlow<T> {
  XFlow(this.facade);

  final Facade facade;
  final _c = Completer<T>();

  @protected
  void flow([String? deepLink]);

  FutureOr<T> run([String? deepLink]) {
    flow(deepLink);
    return T == Null ? Future.value() : _c.future;
  }

  void resolve([T? result]) => _c.complete();
}
