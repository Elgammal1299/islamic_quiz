import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final String answer;
  final int isCorrect;

  const AnswerModel({
    required this.answer,
    required this.isCorrect,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      answer: json['answer'] as String,
      isCorrect: json['t'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      't': isCorrect,
    };
  }

  @override
  List<Object?> get props => [answer, isCorrect];
}
