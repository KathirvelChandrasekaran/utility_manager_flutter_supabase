import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0XFFAD6C98),
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
      ),
    );
  }

  void showErrorSnackBar({
    required String message,
  }) {
    showSnackBar(
      message: message,
    );
  }
}
