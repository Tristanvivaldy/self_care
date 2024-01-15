import 'package:self_care/domain/usecase/signup_param.dart';

import '../../data/repositories/user_repository.dart';
import 'usecase.dart';

class SignUp implements Usecase<void, SignupParam> {
  final UserRepository userRepository;

  SignUp({required this.userRepository});

  @override
  Future<void> call(SignupParam params) async {
    final user = await userRepository.getUser(params.email, params.password);

    if (user != null) {
      throw Exception('User already registered!');
    }

    await userRepository.addUser(params.name, params.email, params.password);

    return;
  }
}
