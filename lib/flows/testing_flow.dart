import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:game_words/framework/_framework.dart';

class WGFlowTest extends XFlow {
  WGFlowTest(this.wordId, super.facade, this.level);

  final int wordId;
  final int level;

  @override
  void flow([String? deepLink]) {
    final word = facade.dataManager.wordById(wordId);
    if (word == null) {
      resolve();
      return;
    }

    final sounds = <int, int>{};
    final words = facade.dataManager
        .wordIdsByLevel(level)
        .remove(wordId)
        .shuffle()
        .getRange(0, 3)
        .toIList()
        .add(wordId)
        .shuffle();

    for (var w in words) {
      sounds[w] = facade.dataManager.soundByWordId(w)?.wordId ?? 0;
    }

    final builder = facade.factory.page.makeTestPageBuilder(
        wordId: wordId,
        words: words,
        onSyllable: (int index) =>
            facade.soundpool.play(facade.dataManager.soundByWordId(wordId)?.syllables[index] ?? 0),
        onTapImage: (int index) async {
          if (wordId == words[index]) {
            facade.soundpool.play(facade.dataManager.soundByWordId(words[index])?.id ?? 0);
            await Future.delayed(const Duration(seconds: 2));
            resolve();
          }
        });

    facade.navigator.next(builder);
  }
}
