import 'package:flutter/material.dart';

import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import '../../views/views.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home_screen';
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // <---- Here would be for categories view
    FavoritesView()
  ];

  // --- Important Note ---
  // In Flutter exists a widget to preserve the state and this is called IndexedStack()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // Important widget to keep alive state of view or screen (section 16 course)
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavbar(currentIndex: pageIndex),
    );
  }
}
