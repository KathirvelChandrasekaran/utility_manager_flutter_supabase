import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/components/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends AuthState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      recoverSupabaseSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Lottie.asset('assets/splash.json'),
          Center(
            child: Text(
              "Utility Manager",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: SizedBox(
              width: 300.0,
              child: LinearProgressIndicator(
                backgroundColor: Color(0XFFBAAAB9),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0XFFAD6C98),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
