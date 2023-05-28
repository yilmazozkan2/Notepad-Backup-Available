import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/padding.dart';
import '../../controller/home_page_controller.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({super.key});
  HomePageController _homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.symetric,
      child: TextField(
        style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 17.5),
        maxLines: null,
        controller: _homePageController.textController,
        decoration: InputDecoration(hintText: 'Bir şeyler yazmaya başlayın'),
      ),
    );
  }
}
