class addTodoParams {
  final String taskName;
  final String description;
  final String dueDate;
  final String type;
  final String time;
  final String user_email;

  addTodoParams(
      {required this.taskName,
      required this.description,
      required this.dueDate,
      required this.type,
      required this.time,
      required this.user_email});
}
