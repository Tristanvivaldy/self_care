import '../../data/repositories/user_repository.dart';
import '../entities/user.dart';
import 'login_param.dart';
import 'usecase.dart';

class Login implements Usecase<User, LoginParam> {
  final UserRepository userRepository;

  Login({required this.userRepository});

  @override
  Future<User> call(LoginParam params) async {
    // autentikasi menggunakan params.email & params.password
    final user = await userRepository.getUser(params.email, params.password);

    if (user == null) {
      throw Exception('User not found!');
    }

    return user;
  }
}
