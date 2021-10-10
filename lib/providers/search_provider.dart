import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utility_manager_flutter/services/search_service.dart';

final urlSearchNotifier = Provider(
  (_) => URLSearchService(),
);
