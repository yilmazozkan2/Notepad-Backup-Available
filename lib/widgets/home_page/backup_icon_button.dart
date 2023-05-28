import 'dart:io';

import 'package:day_planner/widgets/home_page/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BackupIconButton  extends StatelessWidget {
  BackupIconButton ({super.key});

  final _mybox = Hive.box('mybox');
  String _backupPath = '/sdcard/Download/notlar.hive';

 Future<void> backupHiveBox<T>() async {
    final _boxPath = _mybox.path;
    if (_mybox.isOpen) {
      print('mybox açık yedekleme yapıyor');
      try {
        //burada notkutusu.hive adında bi dosya veri tabanının
        // konumundan benim istediğim konuma kopyalanıyor
        File(_boxPath!).copy(_backupPath);
        toastMessage('Download klasörüne yedeklendi');
      } catch (e) {}
    }
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        backupHiveBox();
      },
      icon: Icon(Icons.backup),
      iconSize: 30,
    );
  }
}