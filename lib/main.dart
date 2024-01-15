import 'package:flutter/material.dart';
import 'package:self_care/presentation/pages/boarding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zufhjwsxtkhgkyktsygx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1Zmhqd3N4dGtoZ2t5a3RzeWd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA1NTI5MDAsImV4cCI6MjAxNjEyODkwMH0.a1_qcZHFDSaQQb1Yd1jtGy-_2m3RezqofvsTXiOdYlY',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFF16687E)),
      home: const Boarding(),
    );
  }
}
