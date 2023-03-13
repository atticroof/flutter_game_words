import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'objects.g.dart';

part 'objects.freezed.dart';

@freezed
class Word with _$Word {
  const factory Word({
    required int id,
    required int level,
    required String name,
    required String word,
    required IList<String> syllables,
    required String copyright,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}

@freezed
class WordSound with _$WordSound {
  const factory WordSound({required int wordId, required int id, required IList<int> syllables}) = _WordSound;
}

@freezed
class StateGlobal with _$StateGlobal {
  const factory StateGlobal({required bool loading}) = _StateGlobal;
}
