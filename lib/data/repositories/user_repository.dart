import '../../domain/entities/user.dart';

abstract interface class UserRepository {
  Future<User?> getUser(String email, String password);
  Future<void> addUser(String name, String email, String password);
  Future<User?> updateBMI(String email, String password, int berat, int tinggi);
}
