import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_care/presentation/pages/main_screen.dart';
import 'package:self_care/presentation/pages/signup_page.dart';
import 'package:self_care/presentation/providers/user_data_provider.dart';

class LoginData {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
}

final loginDataProvider = Provider((ref) => LoginData());

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      if (next.valueOrNull != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      }
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
    final loginData = ref.read(loginDataProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          height: 10,
        ),
        Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  Text(
                    "SelfCare",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSansCondensed(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Sign into your Account",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red)),
                          prefixIcon: const Icon(Icons.account_circle_rounded),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0)),
                      controller: loginData.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email is not valid';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
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
                          prefixIcon: const Icon(Icons.lock),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0)),
                      obscureText: true,
                      controller: loginData.password,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password is not valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot your Password?",
                          style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    String emailControl = loginData.email.text;
                    String passwordControl = loginData.password.text;

                    if (emailControl.isNotEmpty && passwordControl.isNotEmpty) {
                      await ref
                          .watch(userDataProvider.notifier)
                          .login(emailControl, passwordControl);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login Error'),
                              content: const Text(
                                  'Please enter both email and password.'),
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
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Or Login with",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("images/google_icons.png"),
                    width: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image(
                    image: AssetImage("images/twitter_icons.png"),
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?",
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
                        builder: (context) => const SignupPage()));
              },
              child: Text(
                " Register Now!!",
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
