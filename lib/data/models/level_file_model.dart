import 'package:equatable/equatable.dart';

class LevelFileModel extends Equatable {
  final int level;
  final String filename;
  final String path;

  const LevelFileModel({
    required this.level,
    required this.filename,
    required this.path,
  });

  factory LevelFileModel.fromJson(Map<String, dynamic> json) {
    return LevelFileModel(
      level: json['level'] as int,
      filename: json['filename'] as String,
      path: json['path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'filename': filename,
      'path': path,
    };
  }

  @override
  List<Object?> get props => [level, filename, path];
}
