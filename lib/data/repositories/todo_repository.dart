import 'package:self_care/domain/entities/todo.dart';

abstract interface class TodoRepository {
  Future<List<ToDo>> getTodos(String email);
  Future<void> saveTodos(String taskName, String description, String dueDate,
      String type, String time, String email);
  Future<void> deleteTodos(int id);
}
