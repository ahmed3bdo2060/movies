import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'aaaaa/aaa.dart';
import 'home.dart';
import 'presentation/core/logic/cash_helper.dart';
import 'presentation/core/logic/helper_methods.dart';
import 'search/search.dart';
import 'service_locator.dart';
import 'test.dart';
import 'test/simple_user.dart';
import 'test/view.dart';

Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final customCacheManager = CacheManager(
   Config("cacheKey",
   stalePeriod: Duration(days: 20),
   maxNrOfCacheObjects: 200)
 );
  SharedPreferences prefss =await SharedPreferences.getInstance();
  await CashHelper.init();
  await EasyLocalization.ensureInitialized();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: "assets/translation",

      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      fallbackLocale: Locale("en"),
      startLocale: Locale("en"),
      child: ScreenUtilInit(
        designSize: Size(375,812),
        child: HomeView(),
        builder: (context, child) => MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: "movies",
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home:child
        ),
      ),
    );
  }
}
