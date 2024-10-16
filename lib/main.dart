import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:NewsLetter/AppTheme/my_behaviour.dart';
import 'package:NewsLetter/splashscreen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // DatabaseHelper.instance;
  // final dbHelper = DatabaseHelper.instance;
  // await dbHelper.dropDataBase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  hexColor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  final Map<int, Color> _yellow700Map = {
    50: const Color(0xff022b50),
    100: const Color(0xff022b50),
    200: const Color(0xff022b50),
    300: const Color(0xff022b50),
    400: const Color(0xff022b50),
    500: const Color(0xff022b50),
    600: const Color(0xff022b50),
    700: const Color(0xff022b50),
    800: const Color(0xff022b50),
    900: const Color(0xff022b50),
  };
  @override
  Widget build(BuildContext context) {
    final MaterialColor _blue900Swatch =
        MaterialColor(_yellow700Map[400]!.value, _yellow700Map);
    return MaterialApp(
      title: 'News Letter',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(), //Design class page
          child: child ?? Container(),
        );
      },
      theme: ThemeData(
        primarySwatch: _blue900Swatch,
        primaryColor: _blue900Swatch,
        primaryColorLight: _blue900Swatch, //Cart items and bannel colors
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SplashScreen(),
    );
  }
}
