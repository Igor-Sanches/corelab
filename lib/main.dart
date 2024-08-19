import 'dart:ui';

import 'package:corelab/structure/route_helper.dart';
import 'package:corelab/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'application/controller/theme_controller.dart';
import 'structure/get_di.dart' as di;
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utilities/messages.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var list = await di.init();
  var languages = list[0];
  bool isBiometry = list[1];

  runApp(ApplicationWidget(languages: languages, isBiometry: isBiometry));
}

class ApplicationWidget extends StatefulWidget {
  final Map<String, Map<String, String>>? languages;
  bool isBiometry;
  ApplicationWidget({super.key, @required this.languages, this.isBiometry = false});

  @override
  State<ApplicationWidget> createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ThemeController>(builder: (themeController) {

      return GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        supportedLocales: const [
          Locale('pt', 'BR')
        ],
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        theme: themeController.darkTheme! ? themeController.darkColor == null ? dark() : dark(color
            : themeController.darkColor!) : themeController.lightColor == null ? light()
            : light(color: themeController.lightColor!),
        locale: const Locale(AppConstants.languageCode, AppConstants.countryCode),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translations: Messages(languages: widget.languages),
        fallbackLocale: const Locale(AppConstants.languageCode, AppConstants.countryCode),
        initialRoute: RouteHelper.getHomeRoute(),
        getPages: RouteHelper.routes,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 500),
      );
    });
  }
}
