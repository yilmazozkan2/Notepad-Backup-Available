import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase{
  final _mybox = Hive.box('mybox');
  List todoList = [];
  List viewList = [];

  void loadData()async{
    todoList = _mybox.get('TODOLIST');
  }
  void loadViewType()async{
    int value = Hive.box('mybox').get('view_type');
    viewList = [value];

  }
  void updateDatabase(){
    //TODOLIST key center in value put on the todoList so.. adding database
    _mybox.put('TODOLIST', todoList);
  }
  void closeDatabase(){
    _mybox.close();
  }

  void updateItem(int index, String newValue) {
    //parantez içindeki index değeri homepageden gönderilen index değeri oluyor
    //[index][0] yaptığımızda da listedeki değer write page den gelen değerle değiştiriliyor
    todoList[index][0] = newValue;
  }

}