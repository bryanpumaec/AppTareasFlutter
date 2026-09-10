class Task {
  final String title;
  final DateTime dueDate;
  final int priority;

  const Task({
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
}
