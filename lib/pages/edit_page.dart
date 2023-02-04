import 'package:day_planner/constants/color.dart';
import 'package:day_planner/constants/padding.dart';
import 'package:day_planner/data/todo_database.dart';
import 'package:day_planner/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TodoDatabase db = TodoDatabase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _args = Get.arguments;
  bool _iconControl = true;
  String _changedValue = '';

  @override
  Widget build(BuildContext context) {
    return buildWillPopScope(context);
  }

  WillPopScope buildWillPopScope(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_iconControl) {
          Get.off(() => HomePage());
        }
        return true;
      },
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteBackground,
      appBar: _buildAppBar(context),
      body: buildForm(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.whiteBackground,
      leading: buildBackIconButton(context),
      actions: [_iconControl ? Icon(null) : buildDoneIconButton(context)],
    );
  }

  IconButton buildBackIconButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (_iconControl) {
          Get.off(() => HomePage());
        }
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: buildGestureDetector(),
          ),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: buildTextFormField(),
    );
  }

  Container buildTextFormField() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: PaddingConstants.onlyLR_TxtFormField,
        child: TextFormField(
          cursorHeight: 200,
          initialValue: _args[0],
          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 17,height: 2),
          onTap: () {
            _iconControl = false;
          },
          onChanged: (value) {
            _changedValue = value;
            setState(() {
              _iconControl = false;
            });
          },
          maxLines: null,
          enabled: true,
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }

  IconButton buildDoneIconButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (_changedValue.isNotEmpty) {
          db.loadData();
          db.updateItem(_args[1], _changedValue);
        }
        _iconControl = true;
        FocusScope.of(context).unfocus();
      },
      icon: Icon(Icons.done, color: Colors.black),
    );
  }
}
