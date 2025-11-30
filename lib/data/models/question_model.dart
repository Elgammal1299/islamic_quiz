import 'package:equatable/equatable.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final int id;
  final String question;
  final int level;
  final String link;
  final String section;
  final List<AnswerModel> answers;

  const QuestionModel({
    required this.id,
    required this.question,
    required this.level,
    required this.link,
    required this.section,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int,
      question: json['q'] as String,
      level: json['level'] as int,
      link: json['link'] as String,
      section: json['section'] as String,
      answers: (json['answers'] as List)
          .map((answer) => AnswerModel.fromJson(answer))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'q': question,
      'level': level,
      'link': link,
      'section': section,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }

  int get correctAnswerIndex {
    return answers.indexWhere((answer) => answer.isCorrect == 1);
  }

  @override
  List<Object?> get props => [id, question, level, link, section, answers];
}
