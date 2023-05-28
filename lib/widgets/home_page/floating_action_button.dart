import 'package:flutter/material.dart';

import '../../constants/color.dart';


class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add,
          color: ColorConstants.floatingIconBackground, size: 30),
      elevation: 0,
      backgroundColor: Colors.black,
    );
  }
}
