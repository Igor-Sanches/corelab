import 'package:corelab/features/pages/view/pages_screen.dart';
import 'package:get/get.dart';

import '../features/search/view/search_screen.dart';


class RouteHelper {
  static const String init = '/init';
  static const String search = '/search';

  static String getHomeRoute() => init;
  static String getSearchRoute({String? queryText}) => '$search?query=${queryText ?? ''}';

  static List<GetPage> routes = [
    GetPage(name: init, page: () => const PagesScreen()),
    GetPage(name: search, page: () => SearchScreen(queryText: Get.parameters['query'])),
  ];

  static String getHtmlRoute(String s) {return'';}

}