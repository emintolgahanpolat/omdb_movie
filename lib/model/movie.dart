import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(nullable: true)
class BaseResponse {
  BaseResponse({
    this.search,
    this.totalResults,
    this.response,
  });

  @JsonKey(name: "Search")
  List<Search> search;
  String totalResults;
  @JsonKey(name: "Response")
  String response;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable(nullable: true)
class Search {
  Search({
    this.title,
    this.year,
    this.imdbId,
    this.type,
    this.poster,
  });

  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Year")
  String year;
  @JsonKey(name: "imdbID")
  String imdbId;
  @JsonKey(name: "Type")
  String type;
  @JsonKey(name: "Poster")
  String poster;

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}

enum Type { MOVIE, SERIES }
