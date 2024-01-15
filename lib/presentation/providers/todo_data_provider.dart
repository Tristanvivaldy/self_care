import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_care/domain/entities/todo.dart';
import 'package:self_care/domain/usecase/add_todo.dart';
import 'package:self_care/domain/usecase/add_todo_param.dart';
import 'package:self_care/domain/usecase/delete_todo.dart';
import 'package:self_care/domain/usecase/todo.dart';
import 'package:self_care/presentation/providers/addtodo_provider.dart';
import 'package:self_care/presentation/providers/deletetodo_provider.dart';
import 'package:self_care/presentation/providers/todo_provider.dart';
import 'package:self_care/presentation/providers/user_data_provider.dart';

part 'todo_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoData extends _$TodoData {
  @override
  Future<List<ToDo>?> build() async {
    final todos = await getList(ref.watch(userDataProvider).value!.email);
    state = AsyncData(todos);
    return todos;
  }

  Future<List<ToDo>?> getList(email) async {
    Todos todos = ref.read(todosProvider);
    var hasil = await todos(email);
    return hasil;
  }

  Future<void> addTodo(String taskName, String description, String dueDate,
      String type, String time, String email) async {
    state = const AsyncLoading();

    AddTodo addTodo = ref.read(addTodoProvider);

    await addTodo(AddTodoParams(
      taskName: taskName,
      description: description,
      dueDate: dueDate,
      type: type,
      time: time,
      userEmail: email,
    ));

    Todos todos = ref.read(todosProvider);
    var hasil = await todos(email);

    state = AsyncData(hasil);
  }

  Future<void> deleteTodo(int id, String email) async {
    state = const AsyncLoading();

    DeleteTodo deleteTodo = ref.read(deleteTodoProvider);

    await deleteTodo(id);

    Todos todos = ref.read(todosProvider);
    var hasil = await todos(email);

    state = AsyncData(hasil);
  }
}
