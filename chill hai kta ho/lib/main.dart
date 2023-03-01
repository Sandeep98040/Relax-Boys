import 'dart:io';

import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/services/NotificationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'GlobalUIViewModel.dart';
import 'Login.dart';
import 'Registration.dart';
import 'authViewModel.dart';
import 'navigation_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService.initialize();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ],
        child: MaterialApp(
            title: 'Flutter UI',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: AppTheme.textTheme,
              platform: TargetPlatform.iOS,
            ),
            initialRoute: "/Navigation",
            routes: {
              "/UserLogin": (context) => UserLogin(),
              "/Registration": (context) => UserRegistration(),
              "/Navigation": (context) => NavigationHomeScreen(),
            }));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
