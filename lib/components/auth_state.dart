import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utility_manager_flutter/utils/constants.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  void onAuthenticated(Session session) async {
    if (mounted) {
      final res = await supabase
          .from('profiles')
          .select()
          .eq('id', session.user?.id)
          .single()
          .execute();
      if (res.status == 406)
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/addDetails', (route) => false);
      else
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    context.showErrorSnackBar(message: message);
  }
}
