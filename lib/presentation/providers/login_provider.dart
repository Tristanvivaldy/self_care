import 'package:self_care/domain/usecase/login.dart';
import 'package:self_care/presentation/providers/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) =>
    Login(userRepository: ref.read(userRepositoryProvider));
