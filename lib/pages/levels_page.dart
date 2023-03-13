import 'package:flutter/material.dart';
import 'package:game_words/framework/_framework.dart';

class LevelsPage extends XPage {
  const LevelsPage(this.onLevelSelected, {super.key, required super.data});

  final ValueChanged<int> onLevelSelected;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                      children: List.generate(
                          data.levels.length,
                          (index) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                  onPressed: () => onLevelSelected(index + 1),
                                  child: Text('Уровень ${index + 1}')))))))));
}
