import 'package:game_words/facade/facade.dart';
import 'package:game_words/flows/_flows.dart';
import 'package:game_words/framework/x_flow.dart';

class FlowFactory {
  FlowFactory(this.facade);

  final Facade facade;

  XFlow makeFlowStartup() => StartupFlow(facade);

  XFlow makeFlowMain() => MainFlow(facade);

  XFlow makeFlowLearnPage(int wordId) => WGFlowLearnWord(wordId, facade);

  XFlow makeFlowTest(int wordId, {required int level}) => WGFlowTest(wordId, facade, level);
}
