import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tikkeul/pages/home.dart';
import 'package:tikkeul/pages/sign_in.dart';
import 'package:tikkeul/pages/sign_up.dart';
import 'package:tikkeul/utils/secure_storage.dart' show getAccessToken;

import 'globals.dart';

void main() async {
  // 기본 언어 초기화
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  var accessToken = await getAccessToken();
  bool _isLogin = accessToken != null && accessToken.isNotEmpty ? true : false;

  String _initialRoute = _isLogin ? '/home' : '/signIn';
  // String _initialRoute = '/test';

  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    scaffoldMessengerKey: snackbarKey,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepPurple,
      ).copyWith(
        secondary: Colors.indigo,
      ),
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
