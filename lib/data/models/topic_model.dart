import 'package:equatable/equatable.dart';
import 'level_file_model.dart';

class TopicModel extends Equatable {
  final String englishName;
  final String arabicName;
  final List<LevelFileModel> files;

  const TopicModel({
    required this.englishName,
    required this.arabicName,
    required this.files,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      englishName: json['englishName'] as String,
      arabicName: json['arabicName'] as String,
      files: (json['files'] as List)
          .map((file) => LevelFileModel.fromJson(file))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'englishName': englishName,
      'arabicName': arabicName,
      'files': files.map((file) => file.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [englishName, arabicName, files];
}
