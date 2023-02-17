// ignore_for_file: public_member_api_docs, sort_constructors_first
class FilterModel {
  final String? tags;
  final bool? isCompleted;
  final int pageKey;
  final int pageSize;
  const FilterModel({
    this.tags,
    this.isCompleted,
    required this.pageKey,
    required this.pageSize,
  });

  FilterModel copyWith({
    String? tags,
    bool? isCompleted,
    int? pageKey,
    int? pageSize,
  }) {
    return FilterModel(
      tags: tags ?? this.tags,
      isCompleted: isCompleted ?? this.isCompleted,
      pageKey: pageKey ?? this.pageKey,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  String toString() {
    return 'FilterModel(tags: $tags, isCompleted: $isCompleted, pageKey: $pageKey, pageSize: $pageSize)';
  }
}
