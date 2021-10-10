import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utility_manager_flutter/services/meta_info_service.dart';
import 'package:utility_manager_flutter/models/meta_info.dart';

class MetaInfoProvider extends ChangeNotifier {
  String _url = "";
  String get url => _url;

  void listenToURL(String url) {
    _url = url;
    notifyListeners();
  }
}

final urlProvider = ChangeNotifierProvider(
  (_) => MetaInfoProvider(),
);

final metaServiceProvider = Provider(
  (_) => MetaInfoService(),
);

final getMetaInfo = FutureProvider.autoDispose.family<MetaInfo?, String>(
  (ref, url) {
    final meta = ref.read(metaServiceProvider);
    return meta.get(url);
  },
);
