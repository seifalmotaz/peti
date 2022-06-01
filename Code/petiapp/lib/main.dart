import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'pages/Home/home.dart';
import 'pages/auth/wrapper/wrapper.dart';
import 'services/init.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitRes res = await InitApp.initAuthService();
  runApp(MyApp(res));
}

class MyApp extends StatelessWidget {
  final InitRes res;
  const MyApp(this.res, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Peti',
      home: !res.isUpdated
          ? const Scaffold()
          : res.isAuthenticated
              ? const HomePage()
              : const AuthWrapperPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: .81,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
    );
  }
}
