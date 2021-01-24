// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
    search: (json['Search'] as List)
        ?.map((e) =>
            e == null ? null : Search.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalResults: json['totalResults'] as String,
    response: json['Response'] as String,
  );
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'Search': instance.search,
      'totalResults': instance.totalResults,
      'Response': instance.response,
    };

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
    title: json['Title'] as String,
    year: json['Year'] as String,
    imdbId: json['imdbID'] as String,
    type: json['Type'] as String,
    poster: json['Poster'] as String,
  );
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'imdbID': instance.imdbId,
      'Type': instance.type,
      'Poster': instance.poster,
    };
