import 'package:day_planner/widgets/edit_page/back_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color.dart';
import '../../data/todo_database.dart';

class EditPageCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  EditPageCustomAppBar({
    Key? key,
    required this.iconControl,
    required this.changedValue,
    required this.context,
    
  }) : super(key: key);
  bool iconControl;
  String changedValue;

  TodoDatabase db = TodoDatabase();
  final _args = Get.arguments;
  BuildContext context;

  @override
  Widget build(context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.whiteBackground,
      leading: BackIconButton(iconControl: iconControl),
      actions: [iconControl ? Icon(null) : buildDoneIconButton(context)],
    );
  }

  IconButton buildDoneIconButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (changedValue.isNotEmpty) {
          db.loadData();
          db.updateItem(_args[1], changedValue);
        }
        iconControl = true;
        FocusScope.of(context).unfocus();
      },
      icon: Icon(Icons.done, color: Colors.black),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
