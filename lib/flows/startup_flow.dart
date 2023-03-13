import 'dart:async';
import 'dart:convert';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';
import 'package:game_words/domain/objects.dart';
import 'package:game_words/domain/states.dart';
import 'package:game_words/framework/x_flow.dart';

class StartupFlow extends XFlow {
  StartupFlow(super.facade);

  Future<int> _loadSound(String name, [int? index]) async => await facade.soundpool
      .load(await rootBundle.load(index == null ? 'assets/sounds/$name.mp3' : 'assets/sounds/$name$index.mp3'));

  Future<void> _loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/words/words.json');
    final jsonData = json.decode(jsonText);
    final words = <Word>[];
    final sounds = <WordSound>[];
    // jsonData['words']?.forEach((w) => words.add(Word.fromJson(w)));
    for (var jsonW in jsonData['words'] ?? []) {
      final word = Word.fromJson(jsonW);
      // if (word.level > 7) continue;
      words.add(word);
    }
    facade.dataManager.mapWords(words);
    for (var w in words) {
      final id = await _loadSound(w.name);
      final syllables = <int>[];
      if (w.syllables.length == 1) {
        syllables.add(id);
      } else {
        for (int i = 0; i < w.syllables.length; i++) {
          syllables.add(await _loadSound(w.name, i + 1));
        }
      }
      sounds.add(WordSound(wordId: w.id, id: id, syllables: syllables.lock));
    }
    facade.dataManager.mapSounds(sounds);
  }

  @override
  void flow([String? deepLink]) async {
    facade.statesManager.willStartApp();
    final builder = facade.factory.page.makePreloaderPageBuilder(onStart: () => resolve());
    facade.navigator.next(builder);
    await _loadJsonData();
    await Future.delayed(const Duration(milliseconds: 666));
    facade.statesManager.didStartApp();
  }
}
