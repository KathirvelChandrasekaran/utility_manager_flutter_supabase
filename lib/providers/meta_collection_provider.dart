import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utility_manager_flutter/providers/single_collection_provider.dart';
import 'package:utility_manager_flutter/services/meta_collection_service.dart';
import 'package:supabase/supabase.dart';

final metaCollectionOfUser = FutureProvider.autoDispose<PostgrestResponse>(
  (_) => MetaCollectionService().getData(),
);

final userSingleMetaCollection =
    FutureProvider.autoDispose.family<PostgrestResponse, String>(
  (ref, collectionName) {
    final row = ref.read(singleCollectionNotifier);
    return row.get(collectionName);
  },
);
