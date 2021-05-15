import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joke_model.g.dart';

@JsonSerializable()
class JokeModel {
  final String text;
  final String author;

  JokeModel({@required this.text, @required this.author});

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);

  Map<String, dynamic> toJson() => _$JokeModelToJson(this);
}
