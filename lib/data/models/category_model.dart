import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String arabicName;
  final String englishName;
  final String description;
  final String path;
  final String icons;

  const CategoryModel({
    required this.id,
    required this.arabicName,
    required this.englishName,
    required this.description,
    required this.path,
    required this.icons,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      arabicName: json['arabicName'] as String,
      englishName: json['englishName'] as String,
      description: json['description'] as String,
      path: json['path'] as String,
      icons: json['icons'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabicName': arabicName,
      'englishName': englishName,
      'description': description,
      'path': path,
      'icons': icons,
    };
  }

  @override
  List<Object?> get props => [id, arabicName, englishName, description, path, icons];
}
