import 'package:json_annotation/json_annotation.dart';

part 'dream.g.dart';

@JsonSerializable()
class Dream {
  final String id;
  final String title;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final int layer;

  Dream({required this.id, required this.title, required this.imageUrl, required this.layer});

  factory Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);

  Map<String, dynamic> toJson() => _$DreamToJson(this);

}