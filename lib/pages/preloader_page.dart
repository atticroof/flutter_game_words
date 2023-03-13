import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:game_words/domain/states.dart';
import 'package:game_words/framework/_framework.dart';

class PreloaderPage extends XStatefulPage<WGStatePreloaderPage> {
  const PreloaderPage(this.onStart, {super.key, required super.data, required super.getState});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Observer(builder: (BuildContext context) {
          switch (getState()) {
            case WGStatePreloaderPage.loading:
              return const Center(
                  child: SizedBox(width: 64, height: 64, child: CircularProgressIndicator(color: Colors.red)));
            case WGStatePreloaderPage.ready:
              return Center(child: ElevatedButton(onPressed: onStart, child: const Text('Играть')));
          }
        }),
      );
}
