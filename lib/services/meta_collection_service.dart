import 'package:supabase/supabase.dart';
import 'package:utility_manager_flutter/utils/constants.dart';

class MetaCollectionService {
  Future<Stream<List<Map<String, dynamic>>>> getUserCollection() async {
    var res = supabase
        .from('UserURLCollection:email=eq.${supabase.auth.currentUser?.email}')
        .stream()
        .execute();
    return res;
  }

  Future<PostgrestResponse> getData() async {
    var res = await supabase
        .from('UserURLCollection')
        .select()
        .eq("email", supabase.auth.currentUser?.email)
        .execute();
    return res;
  }

  Future<PostgrestResponse> get(String collectionName) async {
    var res = await supabase
        .from("URLCollection")
        .select()
        .eq('collection_name', collectionName)
        .eq("created_by", supabase.auth.currentUser?.email)
        .execute();
    return res;
  }
}
