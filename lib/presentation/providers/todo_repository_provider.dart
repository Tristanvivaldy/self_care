import 'package:self_care/data/repositories/todo_repository.dart';
import 'package:self_care/data/supabase/supabase_todo_repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_care/data/supabase/supabase_user_repositories.dart';

part 'todo_repository_provider.g.dart';

@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) =>
    SupabaseTodoRepository(supabase);