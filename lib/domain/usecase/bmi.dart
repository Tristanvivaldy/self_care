import 'package:self_care/domain/entities/user.dart';
import 'package:self_care/domain/usecase/bmi_param.dart';

import '../../data/repositories/user_repository.dart';
import 'usecase.dart';

class BMI implements Usecase<User, BMIParam> {
  final UserRepository userRepository;

  BMI({required this.userRepository});

  @override
  Future<User> call(BMIParam params) async {
    final user = await userRepository.getUser(params.email, params.password);

    if (user == null) {
      throw Exception('User not found!');
    }

    await userRepository.updateBMI(
        params.email, params.password, params.berat, params.tinggi);

    return user;
  }
}
