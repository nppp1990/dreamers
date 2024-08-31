// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) => Dream(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String?,
      layer: (json['layer'] as num).toInt(),
    );

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'layer': instance.layer,
    };
