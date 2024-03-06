import 'package:flutter/material.dart';

class MenuItems {

  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItems({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon
  });


}

const appMenuItems = <MenuItems>[

  MenuItems(
    title: 'Buttons',
    subTitle: 'Many Buttons',
    link: '/buttons',
    icon: Icons.smart_button_outlined
  ),
  MenuItems(
    title: 'Cards',
    subTitle: 'Styled container',
    link: '/cards',
    icon: Icons.credit_card
  ),
  MenuItems(
    title: 'Progress indicators',
    subTitle: 'Generals and controlled',
    link: '/progress',
    icon: Icons.refresh_rounded
  ),
  MenuItems(
    title: 'Snackbars and dialogs',
    subTitle: 'Indicators on screen',
    link: '/snackbar',
    icon: Icons.info_outline
  ),
  MenuItems(
    title: 'Animated container',
    subTitle: 'Stateful widget animated',
    link: '/animated',
    icon: Icons.check_box_outline_blank
  ),
  MenuItems(
    title: 'UI Controls _ Tiles',
    subTitle: 'Flutter series controllers',
    link: '/ui-controller',
    icon: Icons.car_rental_outlined
  ),
  MenuItems(
    title: 'App tutorial',
    subTitle: 'A brief trip of the app',
    link: '/tutorial',
    icon: Icons.accessible_rounded
  ),

  MenuItems(
    title: 'Infinite scroll and Pull',
    subTitle: 'Infinite scroll - pull to refresh',
    link: '/infinite',
    icon: Icons.list_alt_rounded
  ),

];
