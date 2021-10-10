// To parse this JSON data, do
//
//     final metaInfo = metaInfoFromJson(jsonString);

import 'dart:convert';

MetaInfo metaInfoFromJson(String str) => MetaInfo.fromJson(json.decode(str));

String metaInfoToJson(MetaInfo data) => json.encode(data.toJson());

class MetaInfo {
  MetaInfo({
    required this.meta,
    required this.result,
  });

  Meta meta;
  Result result;

  factory MetaInfo.fromJson(Map<String, dynamic> json) => MetaInfo(
        meta: Meta.fromJson(json["meta"]),
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "result": result.toJson(),
      };
}

class Meta {
  Meta({
    required this.site,
    required this.type,
    required this.title,
    required this.description,
    required this.image,
    required this.author,
    required this.datePublished,
  });

  Site site;
  String type;
  String title;
  String description;
  String image;
  String author;
  DateTime datePublished;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        site: Site.fromJson(json["site"]),
        type: json["type"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        author: json["author"],
        datePublished: DateTime.parse(json["datePublished"]),
      );

  Map<String, dynamic> toJson() => {
        "site": site.toJson(),
        "type": type,
        "title": title,
        "description": description,
        "image": image,
        "author": author,
        "datePublished": datePublished.toIso8601String(),
      };
}

class Site {
  Site({
    required this.themeColor,
    required this.name,
    required this.twitter,
    required this.logo,
    required this.canonical,
    required this.favicon,
  });

  String themeColor;
  String name;
  String twitter;
  String logo;
  String canonical;
  String favicon;

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        themeColor: json["theme_color"],
        name: json["name"],
        twitter: json["twitter"],
        logo: json["logo"],
        canonical: json["canonical"],
        favicon: json["favicon"],
      );

  Map<String, dynamic> toJson() => {
        "theme_color": themeColor,
        "name": name,
        "twitter": twitter,
        "logo": logo,
        "canonical": canonical,
        "favicon": favicon,
      };
}

class Result {
  Result({
    required this.status,
  });

  String status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
