import 'package:self_care/data/repositories/todo_repository.dart';

class DeleteTodo {
  final TodoRepository todoRepository;

  DeleteTodo({required this.todoRepository});

  Future<void> call(id) async {
    await todoRepository.deleteTodos(id);

    return;
  }
}
