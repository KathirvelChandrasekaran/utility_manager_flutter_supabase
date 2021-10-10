import 'package:supabase/supabase.dart';
import 'package:utility_manager_flutter/utils/constants.dart';

class TodoListService {
  Future<PostgrestResponse> getUserTodos() async {
    var response = await supabase
        .from('TodoList')
        .select()
        .eq('email', supabase.auth.currentUser?.email)
        .execute();
    return response;
  }
}
