import 'package:day_planner/pages/edit_page.dart';
import 'package:day_planner/pages/home_page.dart';
import 'package:day_planner/routes/routes.dart';
import 'package:get/get.dart';

abstract class Pages {
  static List<GetPage> pages = [
    GetPage(name: Routes.home_page, page: (() => HomePage())),
    GetPage(name: Routes.edit_page, page: (() => EditPage())),
  ];
}
