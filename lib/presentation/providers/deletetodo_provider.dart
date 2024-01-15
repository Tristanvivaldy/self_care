import 'package:self_care/domain/usecase/delete_todo.dart';
import 'package:self_care/presentation/providers/todo_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deletetodo_provider.g.dart';

@riverpod
DeleteTodo deleteTodo(DeleteTodoRef ref) =>
    DeleteTodo(todoRepository: ref.read(todoRepositoryProvider));
