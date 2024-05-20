import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
        // This loader has another shape than the line above
        // child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
