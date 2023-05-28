import 'package:flutter/material.dart';

class HomePageCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Notlar'),
      titleTextStyle:
          Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 25),
      centerTitle: true,
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
