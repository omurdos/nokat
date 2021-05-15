// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeModel _$JokeModelFromJson(Map<String, dynamic> json) {
  return JokeModel(
    text: json['text'] as String,
    author: json['author'] as String,
  );
}

Map<String, dynamic> _$JokeModelToJson(JokeModel instance) => <String, dynamic>{
      'text': instance.text,
      'author': instance.author,
    };
