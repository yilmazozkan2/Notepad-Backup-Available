import 'dart:io';

import 'package:day_planner/widgets/home_page/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RestoreIconButton extends StatelessWidget {
  RestoreIconButton({super.key});

  final _mybox = Hive.box('mybox');
  String _backupPath = '/sdcard/Download/notlar.hive';

  Future<void> restoreHiveBox<T>() async {
    final _boxPath = _mybox.path;
    try {
      File(_backupPath).copy(_boxPath!);

      if (File(_backupPath).existsSync()) {
        toastMessage('Yüklendi yansıması için uygulamayı yeniden başlatın');
      } else {
        toastMessage('Download klasöründe yedek bulunamadı');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        restoreHiveBox();
      },
      icon: Icon(Icons.restore),
      iconSize: 30,
    );
  }
}
