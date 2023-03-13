import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:game_words/facade/facade.dart';
import 'package:game_words/pages/_pages.dart';

class PageFactory {
  PageFactory(this.facade);

  final Facade facade;

  WidgetBuilder makePreloaderPageBuilder({required VoidCallback onStart}) =>
      (_) => PreloaderPage(onStart, data: facade.dataManager, getState: () => facade.statesManager.preloaderPageState);

  WidgetBuilder makeLevelsPageBuilder({required ValueChanged<int> onLevelSelected}) =>
      (_) => LevelsPage(onLevelSelected, data: facade.dataManager);

  WidgetBuilder makeLearnPageBuilder(
          {required int wordId,
          required VoidCallback onTapNext,
          required VoidCallback onWord,
          required ValueChanged<int> onTapSyllable,
          required bool Function({int indexFrom, int indexTo}) onWillAccept,
          required Function(int index) onAccept}) =>
      (_) => WGPageLearnWord(
          data: facade.dataManager,
          getState: () => facade.statesManager.learnPageState,
          wordId: wordId,
          onSyllable: onTapSyllable,
          onWord: onWord,
          onTapNext: onTapNext,
          onWillAccept: onWillAccept,
          onAccept: onAccept);

  WidgetBuilder makeTestPageBuilder(
          {required int wordId,
          required IList<int> words,
          required Function(int) onTapImage,
          required ValueChanged<int> onSyllable}) =>
      (_) => WGPageTest(onTapImage, onSyllable, data: facade.dataManager, wordId: wordId, words: words);
}
