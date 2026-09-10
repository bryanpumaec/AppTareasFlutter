class Task {
  final int? id;
  final String title;
  final DateTime dueDate;
  final int priority;

  const Task({
    this.id,
    required this.title,
    required this.dueDate,
    required this.priority,
  });

  String get formattedDate {
    final day = dueDate.day.toString().padLeft(2, '0');
    final month = dueDate.month.toString().padLeft(2, '0');
    final year = dueDate.year.toString();
    return '$day/$month/$year';
  }

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, Object?> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      dueDate: DateTime.parse(map['dueDate'] as String),
      priority: map['priority'] as int,
    );
  }

  Task copyWith({int? id}) {
    return Task(
      id: id ?? this.id,
      title: title,
      dueDate: dueDate,
      priority: priority,
    );
  }
}
