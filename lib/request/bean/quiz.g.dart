// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String?,
      layer: (json['layer'] as num).toInt(),
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'layer': instance.layer,
    };

QuizInfo _$QuizInfoFromJson(Map<String, dynamic> json) => QuizInfo(
      categoryName: json['category_name'] as String,
      quizzes: (json['quizzes'] as List<dynamic>)
          .map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizInfoToJson(QuizInfo instance) => <String, dynamic>{
      'category_name': instance.categoryName,
      'quizzes': instance.quizzes,
    };

QuestionInfo _$QuestionInfoFromJson(Map<String, dynamic> json) => QuestionInfo(
      id: json['id'] as String,
      title: json['title'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionInfoToJson(QuestionInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'questions': instance.questions,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String,
      content: json['query'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'query': instance.content,
      'options': instance.options,
    };

QuestionOption _$QuestionOptionFromJson(Map<String, dynamic> json) =>
    QuestionOption(
      id: json['id'] as String,
      content: json['option'] as String,
      sort: (json['sort_order'] as num).toInt(),
    );

Map<String, dynamic> _$QuestionOptionToJson(QuestionOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'option': instance.content,
      'sort_order': instance.sort,
    };
