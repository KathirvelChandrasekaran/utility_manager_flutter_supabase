import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:utility_manager_flutter/models/meta_info.dart';

class MetaInfoService {
  Future<MetaInfo?> get(String url) async {
    String _baseURL = "https://api.urlmeta.org/?url=";
    String credentials =
        "kathirvelchandrasekaran@protonmail.com:bWzQYKLvcr9deLH83wvE";
    Codec<String, String> toBase64 = utf8.fuse(base64);
    String encodeURL = toBase64.encode(credentials);
    final uri = Uri.parse(_baseURL + url);
    http.Response response;
    try {
      response = await http.get(
        uri,
        headers: <String, String>{
          'Authorization': "Basic " + encodeURL,
        },
      );
      print(response.body);
      if (response.statusCode == 200)
        // return convert.jsonDecode(response.body) as List;
        return metaInfoFromJson(response.body);
    } on Exception catch (e) {
      print("object");
      print(e);
      throw e;
    }
  }

  Future<dynamic> getMetaInformation(String url) async {
    String _baseURL = "https://api.urlmeta.org/?url=";
    String credentials =
        "kathirvelchandrasekaran@protonmail.com:bWzQYKLvcr9deLH83wvE";

    Codec<String, String> toBase64 = utf8.fuse(base64);
    String encodeURL = toBase64.encode(credentials);
    final uri = Uri.parse(_baseURL + url);
    http.Response response;
    try {
      response = await http.get(
        uri,
        headers: <String, String>{
          'Authorization': "Basic " + encodeURL,
        },
      );
      // print(response.body);
      if (response.statusCode == 200) return convert.jsonDecode(response.body);
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }
}
