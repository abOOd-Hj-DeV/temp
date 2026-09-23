import 'package:equatable/equatable.dart';

class ProgramModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool isCore;
  final int modulesCount;

  const ProgramModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isCore,
    required this.modulesCount,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        isCore: json['is_core'] == true,
        modulesCount: (json['modules_count'] as num?)?.toInt() ?? 0,
      );

  static List<ProgramModel> listFromJson(Map<String, dynamic> json) =>
      (json['programs'] as List? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ProgramModel.fromJson)
          .toList();

  @override
  List<Object?> get props => [id, name, description, isCore, modulesCount];
}
