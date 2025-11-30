import 'package:equatable/equatable.dart';
import 'topic_model.dart';

class CategoryDetailModel extends Equatable {
  final int id;
  final String category;
  final String description;
  final String icons;
  final List<TopicModel> dataArray;

  const CategoryDetailModel({
    required this.id,
    required this.category,
    required this.description,
    required this.icons,
    required this.dataArray,
  });

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailModel(
      id: json['id'] as int,
      category: json['category'] as String,
      description: json['description'] as String,
      icons: json['icons'] as String,
      dataArray: (json['DataArray'] as List)
          .map((topic) => TopicModel.fromJson(topic))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'icons': icons,
      'DataArray': dataArray.map((topic) => topic.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, category, description, icons, dataArray];
}
