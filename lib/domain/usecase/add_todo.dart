import 'package:self_care/data/repositories/todo_repository.dart';
import 'package:self_care/domain/usecase/add_todo_param.dart';

import 'usecase.dart';

class AddTodo implements Usecase<void, AddTodoParams> {
  final TodoRepository todoRepository;

  AddTodo({required this.todoRepository});

  @override
  Future<void> call(AddTodoParams params) async {
    await todoRepository.saveTodos(params.taskName, params.description,
        params.dueDate, params.type, params.time, params.userEmail);

    return;
  }
}
