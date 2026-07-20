import 'dart:developer' show log;
import 'package:crm_app/core/utils/key.dart';
import 'package:crm_app/screen/home/homeScreen.dart';
import 'package:crm_app/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("userdata");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    var token = box.get("token");
    log("Token =========== ${token ?? "No token Found"}");
    return ScreenUtilInit(
      designSize: Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFFF3F3F3),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: SafeArea(
            top: false,
            child: MaterialApp(
              navigatorKey: navigatorKey, 
              scaffoldMessengerKey: scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              title: 'CRM App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              home: token == null ? SplashScreen() : MyBottomNav(),
            ),
          ),
        );
      },
    );
  }
}
