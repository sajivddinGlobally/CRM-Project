import 'dart:developer' show log;
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

  // This widget is the root of your application.
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
              debugShowCheckedModeBanner: false,
              title: 'CRM App',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // TRY THIS: Try running your application with "flutter run". You'll see
                // the application has a purple toolbar. Then, without quitting the app,
                // try changing the seedColor in the colorScheme below to Colors.green
                // and then invoke "hot reload" (save your changes or press the "hot
                // reload" button in a Flutter-supported IDE, or press "r" if you used
                // the command line to start the app).
                //
                // Notice that the counter didn't reset back to zero; the application
                // state is not lost during the reload. To reset the state, use hot
                // restart instead.
                //
                // This works for code too, not just values: Most code changes can be
                // tested with just a hot reload.
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
