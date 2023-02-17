// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'hive_db.dart';

////////////////////////////////////////////////////////////////
//TABLES
////////////////////////////////////////////////////////////////
//   flutter packages pub run build_runner build --delete-conflicting-outputs
////////////////////////////////////////////////////////////////
@HiveType(typeId: 0)
class TodoBox extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String tags;
  @HiveField(4)
  bool isCompleted;
  TodoBox({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'tags': tags,
      'isCompleted': isCompleted,
    };
  }

  factory TodoBox.fromMap(Map<String, dynamic> map) {
    return TodoBox(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      tags: map['tags'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoBox.fromJson(String source) =>
      TodoBox.fromMap(json.decode(source) as Map<String, dynamic>);
}
