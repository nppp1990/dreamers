import 'package:json_annotation/json_annotation.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  final String id;
  final String title;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final int layer;

  Quiz({required this.id, required this.title, required this.imageUrl, required this.layer});

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

@JsonSerializable()
class QuizInfo {
  @JsonKey(name: 'category_name')
  final String categoryName;
  final List<Quiz> quizzes;

  QuizInfo({required this.categoryName, required this.quizzes});

  factory QuizInfo.fromJson(Map<String, dynamic> json) => _$QuizInfoFromJson(json);

  Map<String, dynamic> toJson() => _$QuizInfoToJson(this);
}

@JsonSerializable()
class QuestionInfo {
  final String id;
  final String title;
  final List<Question> questions;

  QuestionInfo({required this.id, required this.title, required this.questions});

  factory QuestionInfo.fromJson(Map<String, dynamic> json) => _$QuestionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionInfoToJson(this);
}

@JsonSerializable()
class Question {
  final String id;
  @JsonKey(name: 'query')
  final String content;
  final List<QuestionOption> options;

  Question({required this.id, required this.content, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class QuestionOption {
  final String id;
  @JsonKey(name: 'option')
  final String content;
  @JsonKey(name: 'sort_order')
  final int sort;

  QuestionOption({required this.id, required this.content, required this.sort});

  factory QuestionOption.fromJson(Map<String, dynamic> json) => _$QuestionOptionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionOptionToJson(this);
}
