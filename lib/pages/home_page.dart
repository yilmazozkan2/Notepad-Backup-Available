import 'dart:io';
import 'package:day_planner/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
//
import 'package:day_planner/constants/color.dart';
import 'package:day_planner/constants/padding.dart';
import 'package:day_planner/controller/home_page_controller.dart';
import 'package:day_planner/data/todo_database.dart';

// Widgets
import '../widgets/home_page/backup_icon_button.dart';
import '../widgets/home_page/build_text_field.dart';
import '../widgets/home_page/home_page_custom_appbar.dart';
import '../widgets/home_page/floating_action_button.dart';
import '../widgets/home_page/restore_icon_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required}) : super(key: key);

  bool isMount = true;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  TodoDatabase _db = new TodoDatabase();
  HomePageController _homePageController = Get.find();
  var _status = 0;

  @override
  void dispose() {
    widget.isMount = false;
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    if (_mybox.get('TODOLIST') != null) {
      _db.loadData();
    }
    if (_mybox.get('view_type') != null) {
      _status = _mybox.get('view_type');
    } else {
      _mybox.put('view_type', _status);
    }

    _mybox.watch(key: (Box box) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: HomePageCustomAppBar(),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: buildBody(context),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          _homePageController.onSave();
          setState(() {});
        },
      ),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        rowIcons(),
        BuildTextField(),
        buildView(),
      ],
    );
  }

  Row rowIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BackupIconButton(),
        RestoreIconButton(),
        changeViewIconButton(),
      ],
    );
  }

  IconButton changeViewIconButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (_status == 0) {
            _status = 1;
          } else {
            _status = 0;
          }
        });
        _mybox.put('view_type', _status);

        _db.loadViewType();
        setState(() {});
      },
      icon: _status == 0 ? Icon(Icons.list) : Icon(Icons.grid_view),
      iconSize: 30,
    );
  }

  Expanded buildView() {
    return Expanded(
      child: Padding(
        padding: PaddingConstants.symetric,
        child: _status == 0 ? listViewBuilder() : gridViewBuilder(),
      ),
    );
  }

  ListView listViewBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildContainer(index, context);
      },
      itemCount: _db.todoList.length,
    );
  }

  GridView gridViewBuilder() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _db.todoList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return buildContainer(index, context);
      },
    );
  }

  Widget buildContainer(index, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed(
          Routes.edit_page,
          arguments: [_db.todoList[index][0], index],
        );
      },
      child: buildDismissible(index, context),
    );
  }

  Dismissible buildDismissible(index, BuildContext context) {
    return Dismissible(
      key: ValueKey(_db.todoList[index]),
      onDismissed: (direction) {
        _db.todoList.removeAt(index);
        _db.updateDatabase();
        setState(() {});
      },
      child: buildDismissilbeChild(index, context),
    );
  }

  Padding buildDismissilbeChild(index, BuildContext context) {
    return Padding(
      padding: PaddingConstants.container,
      child: Container(
        child: Padding(
          padding: PaddingConstants.childContainer,
          child: buildText(index, context),
        ),
        decoration: BoxDecoration(
            color: ColorConstants.containerBackground,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Text buildText(index, BuildContext context) {
    return Text(
      _db.todoList[index][0],
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: Colors.black, fontSize: 17.5),
    );
  }
}
