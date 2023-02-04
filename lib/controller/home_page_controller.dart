import 'package:day_planner/data/todo_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final textController = TextEditingController();
  TodoDatabase db = TodoDatabase();
  final int index = 0;
  String changedValue = '';

  void onSave() {
    db.loadData();
    if (textController.text.isNotEmpty) {
      db.todoList.add([textController.text, false]);
    }
    db.updateDatabase();
    textController.clear();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    super.update(ids, condition);
  }

  @override
  void onInit() {
    print(
        'HomePageController dan kullanılmadığında ram den silinecek bir TextEditingController oluştu');
    super.onInit();
  }

  //dispose ile kullanılma durumu bittiğinde ramden silme gerçekleşecek
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
