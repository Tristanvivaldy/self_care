class AddTodoParams {
  final String taskName;
  final String description;
  final String dueDate;
  final String type;
  final String time;
  final String userEmail;

  AddTodoParams(
      {required this.taskName,
      required this.description,
      required this.dueDate,
      required this.type,
      required this.time,
      required this.userEmail});
}
