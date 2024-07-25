import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tezda_task/core/app_routes.dart';
import 'package:tezda_task/core/init_ctr.dart';
import 'package:tezda_task/core/services/theme_service.dart';
import 'package:tezda_task/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
  if (GetPlatform.isAndroid || GetPlatform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    DevicePreview(
      enabled: kDebugMode,
      tools: [
        ...DevicePreview.defaultTools,
        DevicePreviewScreenshot(
          onScreenshot: screenshotAsFiles(Directory('/storage/emulated/0/Pictures')),
        ),
      ],
      builder: (context) => MyApp(
        theme: initTheme,
      ), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: (context, chilld) {
          return ThemeProvider(
              initTheme: widget.theme,
              duration: 1.seconds,
              builder: (_, theme) {
                return GetMaterialApp(
                    getPages: AppRoutes.routes,
                    initialBinding: InitControllers(),
                    initialRoute: AppRoutes.initialR,
                    locale: DevicePreview.locale(context),
                    builder: DevicePreview.appBuilder,
                    debugShowCheckedModeBanner: false,
                    title: 'Tezda',
                    theme: theme
                    // theme: ThemeData(
                    //     colorScheme: ColorScheme.fromSeed(
                    //       seedColor: Colors.deepPurple,
                    //       // brightness: Brightness.dark,
                    //     ),
                    //     useMaterial3: true,
                    //   ),
                    );
              });
        });
  }
}
