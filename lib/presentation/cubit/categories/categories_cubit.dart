import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/quiz_repository_impl.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final QuizRepository repository;

  CategoriesCubit({required this.repository}) : super(CategoriesInitial());

  Future<void> loadCategories() async {
    emit(CategoriesLoading());
    try {
      final mainData = await repository.getMainData();
      emit(CategoriesLoaded(mainData));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
