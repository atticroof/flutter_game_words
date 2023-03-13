import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:game_words/domain/objects.dart';
import 'package:game_words/domain/states.dart';
import 'package:mobx/mobx.dart';

part 'store_data.g.dart';

class WGStoreDataImpl = WGStoreDataBase with _$WGStoreDataImpl;

abstract class WGStoreData {
  Word? wordById(int id);

  WordSound? soundByWordId(int wordId);

  IList<Word> get words;

  ISet<int> get levels;

  IList<int> wordIdsByLevel(int level);

  String imageByWordId(int id);
}

abstract class WGStoreDataManager extends WGStoreData {
  void reset();

  void mapWords(List<Word> wordsList);

  void mapSounds(List<WordSound> listSounds);
}

abstract class WGStoreDataBase with Store implements WGStoreDataManager {
  @observable
  var _words = <int, Word>{}.lock;

  @override
  Word? wordById(int id) => _words[id];

  @override
  IList<Word> get words => _words.toValueIList();

  @observable
  var _levels = <int>{}.lock;

  @override
  ISet<int> get levels => _levels;

  @override
  // ISet<int> wordIdsByLevel(int level) => _wordsByLevel[level] ?? <int>{}.lock;
  IList<int> wordIdsByLevel(int level) => _words.values.where((w) => w.level == level).map((e) => e.id).toIList();

  @observable
  var _imagesByWordId = <int, String>{}.lock;

  @override
  String imageByWordId(int id) => _imagesByWordId[id] ?? 'assets/images/placeholder.png';

  @observable
  var _sounds = <int, WordSound>{}.lock;

  @override
  WordSound? soundByWordId(int wordId) => _sounds[wordId];

  @override
  @action
  void reset() {
    _words = <int, Word>{}.lock;
    _levels = <int>{}.lock;
    _imagesByWordId = <int, String>{}.lock;
    _sounds = <int, WordSound>{}.lock;
  }

  @override
  @action
  void mapWords(List<Word> wordsList) {
    final words = <int, Word>{};
    final images = <int, String>{};
    final levels = <int>{};

    for (var word in wordsList) {
      words[word.id] = word;
    }

    _words = _words.addMap(words);

    for (var word in _words.values) {
      levels.add(word.level);
      images[word.id] = 'assets/images/${word.name}.png';
    }

    _levels = levels.lock;
    _imagesByWordId = images.lock;
  }

  @override
  @action
  void mapSounds(List<WordSound> listSounds) {
    final sounds = <int, WordSound>{};
    for (var s in listSounds) {
      sounds[s.wordId] = s;
    }
    _sounds = _sounds.addMap(sounds);
  }
}
