
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utility_manager_flutter/screens/account_page.dart';
import 'package:utility_manager_flutter/screens/add_url.dart';
import 'package:utility_manager_flutter/screens/add_user_details.dart';
import 'package:utility_manager_flutter/screens/home.dart';
import 'package:utility_manager_flutter/screens/login.dart';
import 'package:utility_manager_flutter/screens/splash_screen.dart';
import 'package:utility_manager_flutter/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"],
    anonKey: dotenv.env["SUPABASE_ANON_KEY"],
    authCallbackUrlHostname: dotenv.env["SUPABASE_CALLBACK_URL"],
  );
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Color(0XFFAD6C98),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(),
        '/login': (_) => Login(),
        '/account': (_) => AccountPage(),
        '/addDetails': (_) => AddUserDetails(),
        '/home': (_) => Home(),
        '/addURL': (_) => AddURL(),
      },
    );
  }
}
