import '../datasources/quiz_local_datasource.dart';
import '../models/main_data_model.dart';
import '../models/category_detail_model.dart';
import '../models/question_model.dart';

abstract class QuizRepository {
  Future<MainDataModel> getMainData();
  Future<CategoryDetailModel> getCategoryDetail(String categoryPath);
  Future<List<QuestionModel>> getQuestions(String questionPath);
}

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl({required this.localDataSource});

  @override
  Future<MainDataModel> getMainData() async {
    return await localDataSource.getMainData();
  }

  @override
  Future<CategoryDetailModel> getCategoryDetail(String categoryPath) async {
    return await localDataSource.getCategoryDetail(categoryPath);
  }

  @override
  Future<List<QuestionModel>> getQuestions(String questionPath) async {
    return await localDataSource.getQuestions(questionPath);
  }
}
