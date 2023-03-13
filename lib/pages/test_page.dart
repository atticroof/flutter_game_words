import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:game_words/framework/_framework.dart';
import 'package:game_words/widgets/_widgets.dart';

class WGPageTest extends XPage {
  WGPageTest(this.onTapImage, this.onSyllable,
      {super.key, required super.data, required this.wordId, required this.words});

  final ValueChanged<int> onTapImage;
  final ValueChanged<int> onSyllable;
  final int wordId;
  final IList<int> words;

  late final syllables = data.wordById(wordId)?.syllables ?? <String>[].lock;

  Widget _buildTargetSyllable(int index) => Padding(
      padding: const EdgeInsets.all(8.0), child: _buildSyllable(syllables[index], 64, background: Colors.white60));

  Widget _buildSyllable(String syllable, double size, {bool mute = false, Color background = Colors.white38}) =>
      GestureDetector(
          onTap: mute ? null : () => onSyllable(syllables.indexOf(syllable)),
          child: DecoratedBox(
              decoration: BoxDecoration(color: background, borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(syllable.toUpperCase(), style: TextStyle(fontSize: size, color: Colors.black)))));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Stack(children: [
          // _buildImages(MediaQuery.of(context).size),
          Align(
              alignment: Alignment.topLeft,
              child: WGWidgetImageOfWord(
                data.imageByWordId(words[0]),
                onTap: () => onTapImage(0),
              )),
          Align(
              alignment: Alignment.topRight,
              child: WGWidgetImageOfWord(
                data.imageByWordId(words[1]),
                onTap: () => onTapImage(1),
              )),
          Align(
              alignment: Alignment.bottomLeft,
              child: WGWidgetImageOfWord(
                data.imageByWordId(words[2]),
                onTap: () => onTapImage(2),
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: WGWidgetImageOfWord(
                data.imageByWordId(words[3]),
                onTap: () => onTapImage(3),
              )),
          _buildWord(),
        ]));
  }

  Widget _buildImages(Size size) => SizedBox(
        width: size.width,
        height: size.height,
        child: Column(children: [
          Row(children: [
            WGWidgetImageOfWord(data.imageByWordId(words[0])),
            WGWidgetImageOfWord(data.imageByWordId(words[1])),
          ]),
          Row(children: [
            WGWidgetImageOfWord(data.imageByWordId(words[2])),
            WGWidgetImageOfWord(data.imageByWordId(words[3])),
          ])
        ]),
      );

  Widget _buildWord() => Align(
      alignment: Alignment.center,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(syllables.length, (index) => _buildTargetSyllable(index))));
}
