import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/padding.dart';

class TextFormFieldContainer extends StatefulWidget {
  bool iconControl;
  final ValueChanged<String> onChanged;

  TextFormFieldContainer({
    Key? key,
    required this.iconControl,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TextFormFieldContainerState createState() => _TextFormFieldContainerState();
}

class _TextFormFieldContainerState extends State<TextFormFieldContainer> {
  final _args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: PaddingConstants.onlyLR_TxtFormField,
        child: TextFormField(
          cursorHeight: 200,
          initialValue: _args[0],
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontSize: 17, height: 2),
          onTap: () {
            setState(() {
              widget.iconControl = false;
            });
          },
          onChanged: (value) {
            setState(() {
              widget.onChanged(value);
              widget.iconControl = false;
            });
          },
          maxLines: null,
          enabled: true,
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}
