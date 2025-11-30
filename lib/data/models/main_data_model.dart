import 'package:equatable/equatable.dart';
import 'category_model.dart';

class MainDataModel extends Equatable {
  final String description;
  final List<CategoryModel> categories;

  const MainDataModel({
    required this.description,
    required this.categories,
  });

  factory MainDataModel.fromJson(Map<String, dynamic> json) {
    return MainDataModel(
      description: json['description'] as String,
      categories: (json['categories'] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [description, categories];
}
