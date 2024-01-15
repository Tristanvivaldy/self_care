import "package:self_care/data/supabase/supabase_user_repositories.dart";
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/user_repository.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) =>
    SupabaseUserRepository();
