import 'package:self_care/data/repositories/user_repository.dart';
import 'package:self_care/domain/entities/user.dart';
import 'package:supabase/supabase.dart' as data;

final supabase = data.SupabaseClient('https://zufhjwsxtkhgkyktsygx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1Zmhqd3N4dGtoZ2t5a3RzeWd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA1NTI5MDAsImV4cCI6MjAxNjEyODkwMH0.a1_qcZHFDSaQQb1Yd1jtGy-_2m3RezqofvsTXiOdYlY');

class SupabaseUserRepository implements UserRepository {
  @override
  Future<User?> getUser(String email, String password) async {
    final response =
        await supabase.from('account').select('*').eq('email', email);

    if (response.isNotEmpty) {
      final userPassword = response[0]['password'] as String;

      if (userPassword == password) {
        return User(
            name: response[0]['name'] as String,
            email: response[0]['email'] as String,
            password: response[0]['password'] as String,
            berat: response[0]['berat'] as int?,
            tinggi: response[0]['tinggi'] as int?);
      }
    }
    return null;
  }

  @override
  Future<void> addUser(String name, String email, String password) async {
    await supabase
        .from('account')
        .insert({"name": name, "email": email, "password": password});
    return;
  }

  @override
  Future<User?> updateBMI(
      String email, String password, int berat, int tinggi) async {
    await supabase
        .from("account")
        .update({"berat": berat, "tinggi": tinggi}).eq("email", email);

    final result = await getUser(email, password);
    return result;
  }
}
