import 'package:supabase/supabase.dart';
import 'package:utility_manager_flutter/utils/constants.dart';

class URLSearchService {
  Future<PostgrestResponse> get(String query) async {
    var res = await supabase
        .from('URLCollection')
        .select()
        .eq('created_by', supabase.auth.currentUser?.email)
        .like('url', "%$query%")
        .execute();
    return res;
  }
}
