import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/quiz_repository_impl.dart';
import 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  final QuizRepository repository;

  TopicsCubit({required this.repository}) : super(TopicsInitial());

  Future<void> loadTopics(String categoryPath) async {
    emit(TopicsLoading());
    try {
      final categoryDetail = await repository.getCategoryDetail(categoryPath);
      emit(TopicsLoaded(categoryDetail));
    } catch (e) {
      emit(TopicsError(e.toString()));
    }
  }
}
