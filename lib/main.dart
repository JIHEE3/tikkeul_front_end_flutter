import 'package:flutter/material.dart';
import 'package:tikkeul/pages/home.dart';
import 'package:tikkeul/pages/sign_in.dart';
import 'package:tikkeul/pages/sign_up.dart';

import 'globals.dart';

void main() {
  bool _isLogin = false;
  String _initialRoute = _isLogin ? '/home' : '/signIn';
  // String _initialRoute = '/test';

  // runApp(const MyApp());
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    scaffoldMessengerKey: snackbarKey,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepPurple,
      ).copyWith(
        secondary: Colors.indigo,
      ),
      // textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
    ),
    title: 'Tikkeul',
    initialRoute: _initialRoute,
    routes: {
      '/home': (context) => Home(),
      // "/signIn" route로 이동하면, SignIn 위젯을 생성합니다.
      '/signIn': (context) => SignIn(),
      '/signUp': (context) => SignUp(),
      // '/test': (context) => ,
    },
  ));
}
