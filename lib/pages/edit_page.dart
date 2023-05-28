import 'package:day_planner/constants/color.dart';
import 'package:day_planner/data/todo_database.dart';
import 'package:day_planner/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Widgets
import '../widgets/edit_page/build_text_form_field.dart';
import '../widgets/edit_page/edit_page_custom_appbar.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TodoDatabase db = TodoDatabase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _args = Get.arguments;
  bool iconControl = true;
  String changedValue = '';

  @override
  Widget build(BuildContext context) {
    return buildWillPopScope(context);
  }

  WillPopScope buildWillPopScope(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (iconControl) {
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
      appBar: EditPageCustomAppBar(
        changedValue: changedValue,
        context: context,
        iconControl: iconControl,
      ),
      body: buildForm(),
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
      child: TextFormFieldContainer(
        iconControl: iconControl,
        onChanged: (String value) {
          changedValue = value;
          setState(() {
            iconControl = false;
          });
        },
      ),
    );
  }
}
