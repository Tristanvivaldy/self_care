import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_care/presentation/pages/login_page.dart';
import 'package:self_care/presentation/providers/user_data_provider.dart';

class RegisterData {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordValidator = TextEditingController();
}

final registerDataProvider = Provider((ref) => RegisterData());

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Color(0xFF16697A), Color(0xFF82C0CC)],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  )),
                )),
            ClipPath(
                clipper: CustomClipPath2(),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Color(0xFF16697A), Color(0xFF82C0CC)],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  )),
                )),
            const WidgetContent(),
          ]),
        ),
      ),
    );
  }
}

class WidgetContent extends ConsumerWidget {
  const WidgetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerData = ref.read(registerDataProvider);
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              Text(
                "Sign Up",
                style: GoogleFonts.openSansCondensed(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Please Fill this Form",
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red)),
                      prefixIcon: const Icon(Icons.account_circle_rounded),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0)),
                  controller: registerData.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is not valid';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red)),
                      prefixIcon: const Icon(Icons.email),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0)),
                  controller: registerData.email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is not valid';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red)),
                      prefixIcon: const Icon(Icons.lock_outline),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0)),
                  obscureText: true,
                  controller: registerData.password,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is not valid';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Re-type Password',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red)),
                      prefixIcon: const Icon(Icons.lock),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0)),
                  obscureText: true,
                  controller: registerData.passwordValidator,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is not valid';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                String nameControl = registerData.name.text;
                String emailControl = registerData.email.text;
                String passwordControl = registerData.password.text;
                String passwordValidatorControl =
                    registerData.passwordValidator.text;

                if (nameControl.isNotEmpty &&
                    emailControl.isNotEmpty &&
                    passwordControl.isNotEmpty &&
                    passwordValidatorControl.isNotEmpty) {
                  if (passwordControl == passwordValidatorControl) {
                    await ref
                        .watch(userDataProvider.notifier)
                        .add(nameControl, emailControl, passwordControl);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Signup Error'),
                            content: const Text("Your Password doesn't match."),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"))
                            ],
                          );
                        });
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Signup Error'),
                          content: const Text('Please Fill up the form!'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Ok"))
                          ],
                        );
                      });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color(0xFF16687E),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                textStyle: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              child: const Text("Sign Up"),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have an account?",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300))),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: Text(
                  " Login Now!!",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.15);
    path.quadraticBezierTo(
      size.width / 1,
      size.height * -0.01,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height / 1.1);
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 1.05,
      size.width,
      size.height / 1.1,
    );
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
