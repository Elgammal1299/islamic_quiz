import 'package:equatable/equatable.dart';
import '../../../data/models/category_detail_model.dart';

abstract class TopicsState extends Equatable {
  const TopicsState();

  @override
  List<Object?> get props => [];
}

class TopicsInitial extends TopicsState {}

class TopicsLoading extends TopicsState {}

class TopicsLoaded extends TopicsState {
  final CategoryDetailModel categoryDetail;

  const TopicsLoaded(this.categoryDetail);

  @override
  List<Object?> get props => [categoryDetail];
}

class TopicsError extends TopicsState {
  final String message;

  const TopicsError(this.message);

  @override
  List<Object?> get props => [message];
}
