import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_words/domain/objects.dart';

part 'states.freezed.dart';

part 'states.g.dart';

enum WGStatePreloaderPage { loading, ready }

@freezed
class WGStateLearnPage with _$WGStateLearnPage {
  const WGStateLearnPage._();

  const factory WGStateLearnPage({
    required int wordId,
    required IList<bool> solvedSyllables,
    required int currentIndex,
  }) = _WGStateLearnPage;

  bool get complete => solvedSyllables.last;

  WGStateLearnPage solve() => copyWith(
      solvedSyllables: solvedSyllables.put(currentIndex, true),
      currentIndex: min(solvedSyllables.length - 1, currentIndex + 1));

  factory WGStateLearnPage.fromJson(Map<String, dynamic> json) => _$WGStateLearnPageFromJson(json);

  factory WGStateLearnPage.fromWord(Word word) => WGStateLearnPage(
      wordId: word.id, solvedSyllables: List.generate(word.syllables.length, (_) => false).lock, currentIndex: 0);
}
