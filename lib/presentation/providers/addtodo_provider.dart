import 'package:self_care/domain/usecase/add_todo.dart';
import 'package:self_care/presentation/providers/todo_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'addtodo_provider.g.dart';

@riverpod
AddTodo addTodo(AddTodoRef ref) =>
    AddTodo(todoRepository: ref.read(todoRepositoryProvider));
