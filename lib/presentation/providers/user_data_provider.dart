import 'package:self_care/domain/usecase/bmi.dart';
import 'package:self_care/domain/usecase/bmi_param.dart';
import 'package:self_care/domain/usecase/login_param.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_care/domain/usecase/signup.dart';
import 'package:self_care/domain/usecase/signup_param.dart';
import 'package:self_care/presentation/providers/bmi_provider.dart';
import 'package:self_care/presentation/providers/signup_provider.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecase/login.dart';
import 'login_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async => null;

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var user = await login(LoginParam(email: email, password: password));

    state = AsyncData(user);
  }

  Future<void> add(String name, String email, String password) async {
    state = const AsyncLoading();

    SignUp signup = ref.read(signupProvider);

    await signup(SignupParam(name: name, email: email, password: password));

    state = const AsyncData(null);
  }

  Future<void> updateBMI(
      String email, String password, int berat, int tinggi) async {
    state = const AsyncLoading();

    BMI bmi = ref.read(bmiProvider);

    await bmi(BMIParam(
        email: email, password: password, berat: berat, tinggi: tinggi));

    Login login = ref.read(loginProvider);

    var user = await login(LoginParam(email: email, password: password));

    state = AsyncData(user);
  }

  Future<void> logout() async {
    state = const AsyncData(null);
  }
}
