import 'package:self_care/data/repositories/todo_repository.dart';
import 'package:self_care/domain/entities/todo.dart';
import 'package:supabase/supabase.dart';

class SupabaseTodoRepository implements TodoRepository {
  final SupabaseClient supabase;

  SupabaseTodoRepository(this.supabase);

  @override
  Future<List<ToDo>> getTodos(String email) async {
    final response =
        await supabase.from('list').select('*').eq('user_email', email);
    List<ToDo> result = <ToDo>[];

    for (var todoData in response) {
      result.add(
        ToDo(
          id: todoData['id'],
          taskName: todoData['task_name'],
          description: todoData['description'],
          dueDate: todoData['due_date'],
          type: todoData['type'],
          time: todoData['time'],
          isCompleted: todoData['is_completed'],
        ),
      );
    }

    return result;
  }

  @override
  Future<void> saveTodos(String taskName, String description, String dueDate,
      String type, String time, String email) async {
    await supabase.from('list').insert({
      "task_name": taskName,
      "description": description,
      "due_date": dueDate,
      "type": type,
      "time": time,
      "user_email": email,
    });
    return;
  }

  @override
  Future<void> deleteTodos(int? id) async {
    if (id != null) {
      await supabase.from('list').delete().eq('id', id);
    }
    return;
  }
}
