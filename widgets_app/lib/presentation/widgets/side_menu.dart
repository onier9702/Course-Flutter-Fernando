import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final currentMenu = appMenuItems[value];
        context.push(currentMenu.link);
        // Close the side menu
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const Text('Main'),
        ),

        // const NavigationDrawerDestination(
        //   icon: Icon(Icons.add),
        //   label: Text('Home screen')
        // ),

        ...appMenuItems
          .sublist(0,3)
          .map((itemMenu) => NavigationDrawerDestination(
            icon: Icon(itemMenu.icon),
            label: Text(itemMenu.title),
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More options'),
        ),

        ...appMenuItems
          .sublist(3)
          .map((itemMenu) => NavigationDrawerDestination(
            icon: Icon(itemMenu.icon),
            label: Text(itemMenu.title),
          ),
        ),

      ]
    );
  }
}