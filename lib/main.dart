import 'package:day_planner/constants/color.dart';
import 'package:day_planner/controller/home_page_controller.dart';
import 'package:day_planner/routes/pages.dart';
import 'package:day_planner/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('mybox');
  await Hive.openBox('settings');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  Get.put<HomePageController>(HomePageController());

  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home_page,
      getPages: Pages.pages,
    );
  }
}
