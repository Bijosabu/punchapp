import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData Icon;

  const DrawerItem({
    required this.title,
    required this.Icon,
  });

}

class DrawerItems {
  static const home = DrawerItem(title: 'Home', Icon: Icons.home);
  static const Profile = DrawerItem(title: "Profile", Icon: Icons.person);
  static const activities = DrawerItem(title: "Today's Activities", Icon: Icons.event_note);
  //static const leave = DrawerItem(title: "Leave Application", Icon: Icons.edit_calendar);
  static const help = DrawerItem(title: "Help", Icon: Icons.help);

  static final List<DrawerItem> all = [
    home,
    Profile,
    activities,
    // leave,
    help,
  ];
}