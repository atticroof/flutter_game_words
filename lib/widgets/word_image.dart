import 'dart:ui';

import 'package:flutter/widgets.dart';

class WGWidgetImageOfWord extends StatelessWidget {
  const WGWidgetImageOfWord(this.asset, {super.key, this.onTap, this.height = .5, this.width = .5});

  final String asset;
  final VoidCallback? onTap;

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => onTap == null
      ? _build(MediaQuery.of(context).size)
      : GestureDetector(onTap: onTap, child: _build(MediaQuery.of(context).size));

  Widget _build(Size size) => Stack(children: [
        SizedBox(
          width: size.width * width,
          height: size.height * height,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Image.asset(asset, fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: size.width * width,
          height: size.height * height,
          child: Image.asset(asset, fit: BoxFit.contain),
        )
      ]);
}
