import 'dart:ui';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:game_words/domain/states.dart';
import 'package:game_words/framework/_framework.dart';
import 'package:game_words/widgets/_widgets.dart';

class _Syllable {
  _Syllable(this.index, this.text);

  final int index;
  final String text;
}

class WGPageLearnWord extends XStatefulPage<WGStateLearnPage> {
  WGPageLearnWord(
      {super.key,
      required super.data,
      required this.wordId,
      required this.onSyllable,
      required this.onWord,
      required this.onTapNext,
      required this.onWillAccept,
      required this.onAccept,
      required super.getState});

  final int wordId;

  final VoidCallback onWord;
  final ValueChanged<int> onSyllable;
  final VoidCallback onTapNext;

  final bool Function({int indexFrom, int indexTo}) onWillAccept;
  final Function(int index) onAccept;

  late final syllables = _makeSyllables();
  late final syllablesRandom = _shuffle(syllables);

  IList<_Syllable> _makeSyllables() {
    final syllables = data.wordById(wordId)?.syllables ?? <String>[].lock;
    final result = <_Syllable>[];
    for (int i = 0; i < syllables.length; i++) {
      result.add(_Syllable(i, syllables[i]));
    }
    return result.lock;
  }

  IList<_Syllable> _shuffle(IList<_Syllable> from) {
    final result = from.asList();
    // result.shuffle();
    return result.reversedView.lock;
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: Observer(builder: (BuildContext context) {
        final state = getState();
        final size = MediaQuery.of(context).size;
        return Stack(children: [
          WGWidgetImageOfWord(
            data.imageByWordId(wordId),
            onTap: onTapNext,
            width: 1,
            height: 1,
          ),
          _buildOverlay(state),
          _buildSyllablesMainRow(state, size.height),
          _buildSyllablesRandomRow(state)
        ]);
      }));

  Widget _buildOverlay(WGStateLearnPage state) => Positioned.fill(
      child: AnimatedOpacity(
          opacity: state.complete ? 0 : 1,
          duration: const Duration(seconds: 2),
          child: BackdropFilter(filter: ImageFilter.blur(sigmaY: 100, sigmaX: 100), child: const SizedBox())));

  Widget _buildSyllablesRandomRow(WGStateLearnPage state) => Positioned(
      bottom: 48,
      left: 8,
      right: 8,
      child: AnimatedOpacity(
          opacity: state.complete ? 0 : 1,
          duration: const Duration(seconds: 2),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  syllablesRandom.length,
                  (index) => _buildDraggableSyllable(
                      syllablesRandom[index], state.solvedSyllables[syllablesRandom[index].index])))));

  Widget _buildSyllablesMainRow(WGStateLearnPage state, double height) => AnimatedPositioned(
      left: 8,
      right: 8,
      bottom: state.complete ? 64 : height / 3,
      duration: const Duration(seconds: 2),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              List.generate(syllables.length, (index) => _buildTargetSyllable(index, state.solvedSyllables[index]))));

  Widget _buildTargetSyllable(int index, bool solved) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: DragTarget<_Syllable>(
          onWillAccept: (data) => data == null ? false : onWillAccept(indexFrom: data.index, indexTo: index),
          onAccept: (_) => onAccept(index),
          builder: (_, accepted, rejected) => Observer(
              builder: (BuildContext context) =>
                  _buildSyllable(syllables[index], 64, background: solved ? Colors.blueGrey : Colors.white38))));

  Widget _buildSyllable(_Syllable syllable, double size, {bool mute = false, Color background = Colors.white38}) =>
      GestureDetector(
          onTap: mute ? null : () => onSyllable(syllable.index),
          child: DecoratedBox(
              decoration: BoxDecoration(color: background, borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(syllable.text.toUpperCase(), style: TextStyle(fontSize: size, color: Colors.black)))));

  Widget _buildDraggableSyllable(_Syllable syllable, bool solved) => Padding(
      padding: const EdgeInsets.all(8.0), child: solved ? _buildSyllable(syllable, 48) : _buildDraggable(syllable));

  Widget _buildDraggable(_Syllable syllable) => Draggable<_Syllable>(
      data: syllable,
      feedback: Material(child: _buildSyllable(syllable, 56, mute: true)),
      child: _buildSyllable(syllable, 48));
}
