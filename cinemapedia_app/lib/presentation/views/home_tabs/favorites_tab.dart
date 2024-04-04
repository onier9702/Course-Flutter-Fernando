import 'package:flutter/material.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Tab'),
      ),
      body: const Center(
        child: Text('Favorites'),
      ),
    );
  }
}