import 'package:equatable/equatable.dart';
import '../../../data/models/main_data_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final MainDataModel mainData;

  const CategoriesLoaded(this.mainData);

  @override
  List<Object?> get props => [mainData];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}
