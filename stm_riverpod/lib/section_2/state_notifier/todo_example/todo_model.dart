class Todo{
  final int id;
  final String title;
  final bool isCompleted;

  Todo({required this.id, required this.title, required this.isCompleted});

  Todo copyWith({int? id, String? title, bool? isCompleted}) {
    return Todo(id: id ?? this.id, title: title ?? this.title, isCompleted: isCompleted ?? this.isCompleted);
  }
}