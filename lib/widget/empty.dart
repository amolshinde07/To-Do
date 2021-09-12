import 'package:flutter/material.dart';
import 'package:test_inherited/config/config.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      image: new DecorationImage(
        fit: BoxFit.contain,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.color),
            image: AssetImage(AppImage.emptyImage),
      ),
    ));
  }
}
