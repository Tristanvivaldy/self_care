import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_care/domain/usecase/todo.dart';
import 'package:self_care/presentation/providers/todo_repository_provider.dart';

part 'todo_provider.g.dart';

@riverpod
Todos todos(TodosRef ref) =>
    Todos(todoRepository: ref.read(todoRepositoryProvider));
