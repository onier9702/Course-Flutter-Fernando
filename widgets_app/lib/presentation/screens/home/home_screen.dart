import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    const List<MenuItems> menuItems = appMenuItems;

    return ListView.builder(
      // physics: const BouncingScrollPhysics(),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final menu = menuItems[index];

        return _CustomListTile(menu: menu);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {

  final MenuItems menu;

  const _CustomListTile({
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menu.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menu.title),
      subtitle: Text(menu.subTitle),
      onTap: () {

        // Flutter native navigation
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const ButtonsScreen()
        //   )
        // );

        // Flutter native navigation
        // Navigator.pushNamed(context, menu.link);

        // Solution with go_route
        context.push(menu.link);

      },
    );
  }
}
