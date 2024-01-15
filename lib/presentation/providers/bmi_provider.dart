import 'package:self_care/domain/usecase/bmi.dart';
import 'package:self_care/presentation/providers/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bmi_provider.g.dart';

@riverpod
BMI bmi(BmiRef ref) => BMI(userRepository: ref.read(userRepositoryProvider));
