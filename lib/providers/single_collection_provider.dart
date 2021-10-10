import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utility_manager_flutter/services/meta_collection_service.dart';

final singleCollectionNotifier = Provider((_) => MetaCollectionService());
