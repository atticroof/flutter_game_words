import 'package:game_words/framework/_framework.dart';

class WGFlowLearnWord extends XFlow {
  WGFlowLearnWord(this.wordId, super.facade);

  final int wordId;

  @override
  void flow([String? deepLink]) {
    final word = facade.dataManager.wordById(wordId);
    if (word == null) {
      resolve();
      return;
    }

    final wordSound = facade.dataManager.soundByWordId(wordId);
    if (wordSound == null) {
      resolve();
      return;
    }

    facade.statesManager.learnWillStart(word);

    final builder = facade.factory.page.makeLearnPageBuilder(
        wordId: word.id,
        onTapNext: () async {
          if (!facade.statesManager.learnPageState.complete) return;
          facade.soundpool.play(wordSound.id);
          resolve();
        },
        onWord: () {},
        // () => facade.soundpool.play(wordSound.id),
        onTapSyllable: (index) => facade.soundpool.play(wordSound.syllables[index]),
        onWillAccept: _onWillAccept,
        onAccept: (int index) => facade.statesManager.learnSolveNext());

    facade.navigator.next(builder);
  }

  bool _onWillAccept({int indexFrom = 0, int indexTo = 0}) => indexFrom == indexTo && _indexIsFirstUnsolved(indexTo);

  bool _indexIsFirstUnsolved(int index) {
    if (index == 0) return true;

    final solved = facade.statesManager.learnPageState.solvedSyllables;
    if (index >= solved.length) return false;

    return solved[index - 1];
  }
}
