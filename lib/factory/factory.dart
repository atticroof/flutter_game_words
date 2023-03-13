import 'package:game_words/facade/facade.dart';
import 'package:game_words/factory/flow_factory.dart';
import 'package:game_words/factory/page_factory.dart';

class Factory {
  Factory(this.facade);

  final Facade facade;

  late final flow = FlowFactory(facade);
  late final page = PageFactory(facade);
}
