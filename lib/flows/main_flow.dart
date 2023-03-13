import 'package:game_words/framework/_framework.dart';

class MainFlow extends XFlow {
  MainFlow(super.facade);

  void _startLearnLevel(int level) async {
    final wordsOfLevel = facade.dataManager.wordIdsByLevel(level).shuffle();

    for (int i = 0; i < wordsOfLevel.length; i++) {
      await facade.factory.flow.makeFlowLearnPage(wordsOfLevel[i]).run();
    }

    final words2test = wordsOfLevel.shuffle();

    for (int wordId in words2test) {
      await facade.factory.flow.makeFlowTest(wordId, level: level).run();
    }

    _showLevels();
  }

  void _showLevels() => facade.navigator
      .first(facade.factory.page.makeLevelsPageBuilder(onLevelSelected: (level) => _startLearnLevel(level)));

  @override
  void flow([String? deepLink]) => _showLevels();
}
