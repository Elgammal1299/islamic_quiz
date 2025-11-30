import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/main_data_model.dart';
import '../models/category_detail_model.dart';
import '../models/question_model.dart';

abstract class QuizLocalDataSource {
  Future<MainDataModel> getMainData();
  Future<CategoryDetailModel> getCategoryDetail(String categoryPath);
  Future<List<QuestionModel>> getQuestions(String questionPath);
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  @override
  Future<MainDataModel> getMainData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/main.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return MainDataModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load main data: $e');
    }
  }

  @override
  Future<CategoryDetailModel> getCategoryDetail(String categoryPath) async {
    try {
      // Convert path from /database/tafseer.json to assets/json/tafseer.json
      final String assetPath = categoryPath.replaceFirst('/database/', 'assets/json/');
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return CategoryDetailModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load category detail: $e');
    }
  }

  @override
  Future<List<QuestionModel>> getQuestions(String questionPath) async {
    try {
      // Convert path from /database/tafseer/yoosuf/level-1.json to assets/json/tafseer/yoosuf/level-1.json
      final String assetPath = questionPath.replaceFirst('/database/', 'assets/json/');
      final String jsonString = await rootBundle.loadString(assetPath);
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((question) => QuestionModel.fromJson(question)).toList();
    } catch (e) {
      throw Exception('Failed to load questions: $e');
    }
  }
}
