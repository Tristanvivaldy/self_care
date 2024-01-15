class ToDo {
  final int? id;
  final String? taskName;
  final String? description;
  final String? dueDate;
  final String? type;
  final String? time;
  final bool? isCompleted;

  ToDo(
      {required this.id,
      required this.taskName,
      required this.description,
      required this.dueDate,
      required this.type,
      required this.time,
      required this.isCompleted});
}
