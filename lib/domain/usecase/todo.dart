import 'package:self_care/data/repositories/todo_repository.dart';
import 'package:self_care/domain/entities/todo.dart';

class Todos {
  final TodoRepository todoRepository;

  Todos({required this.todoRepository});

  Future<List<ToDo>> call(email) async {
    final todos = await todoRepository.getTodos(email);

    return todos;
  }
}
