import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:game_words/domain/objects.dart';
import 'package:game_words/domain/states.dart';
import 'package:mobx/mobx.dart';

part 'store_states.g.dart';

class WGStoreStates = WGStatesStoreBase with _$WGStoreStates;

abstract class WGStatesStoreBase with Store {
  @observable
  WGStatePreloaderPage _preloaderPageState = WGStatePreloaderPage.loading;

  WGStatePreloaderPage get preloaderPageState => _preloaderPageState;

  @action
  void willStartApp() => _preloaderPageState = WGStatePreloaderPage.loading;

  @action
  void didStartApp() => _preloaderPageState = WGStatePreloaderPage.ready;

  @observable
  WGStateLearnPage _learnPageState = WGStateLearnPage(wordId: -1, solvedSyllables: <bool>[].lock, currentIndex: 0);

  WGStateLearnPage get learnPageState => _learnPageState;

  @action
  void learnWillStart(Word word) => _learnPageState = WGStateLearnPage.fromWord(word);

  @action
  void learnSolveNext() => _learnPageState = _learnPageState.solve();
}
