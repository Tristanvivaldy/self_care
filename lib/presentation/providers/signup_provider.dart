import 'package:self_care/domain/usecase/signup.dart';
import 'package:self_care/presentation/providers/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_provider.g.dart';

@riverpod
SignUp signup(SignupRef ref) =>
    SignUp(userRepository: ref.read(userRepositoryProvider));
