
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/home_page.dart';

class BackIconButton extends StatelessWidget {
  bool iconControl;

  BackIconButton({super.key,
    required this.iconControl,
  
  });

  @override
  Widget build(BuildContext context) {
     return IconButton(
      onPressed: () {
        if (iconControl) {
          Get.off(() => HomePage());
        }
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }
}