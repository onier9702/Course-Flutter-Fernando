import 'package:flutter/material.dart';

class GradientBgVideo extends StatelessWidget {

  final List<Color> colors;

  const GradientBgVideo({
    super.key,
    this.colors = const[
      Colors.transparent,
      Colors.black87,
    ]
  });

  @override
  Widget build(BuildContext context) {

    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black,
            ],
            stops: [0.7, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        )
      ),
    );
  }
}