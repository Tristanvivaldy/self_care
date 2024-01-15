import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_care/presentation/pages/bmi_mass.dart';
import 'package:self_care/presentation/pages/login_page.dart';
import 'package:self_care/presentation/providers/user_data_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF16697A), Color(0xFF82C0CC)],
                begin: Alignment.topLeft,
                end: Alignment.topRight)),
        child: Stack(children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250))),
          ),
          const Center(child: WidgetContent()),
        ]),
      ),
    );
  }
}

class WidgetContent extends ConsumerWidget {
  const WidgetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var berat = ref.watch(userDataProvider).value?.berat;
    var tinggi = ref.watch(userDataProvider).value?.tinggi;
    berat ??= 0;
    tinggi ??= 0;
    var bmi = berat / ((tinggi / 100) * (tinggi / 100));
    String kategori;
    if (bmi < 18.5) {
      kategori = "Underweight";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      kategori = "Normal";
    } else if (bmi >= 25 && bmi <= 29.9) {
      kategori = "Overweight";
    } else if (bmi >= 30) {
      kategori = "Obesitas";
    } else {
      kategori = "-";
    }
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next.valueOrNull == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
    );
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("images/profile_avatar.jpg"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          ref.watch(userDataProvider).value?.name ?? "Person",
          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          ref.watch(userDataProvider).value?.email ?? "No Email",
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w200),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BMIPage()));
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: MediaQuery.of(context).size.height * 0.225,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Text(
                  "Profile",
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height * 0.14,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.75 / 3,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    "Berat",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  Text(
                                    berat.toString(),
                                    style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "kg",
                                    style: GoogleFonts.inter(fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.75 / 3,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    "Tinggi",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  Text(
                                    tinggi.toString(),
                                    style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "cm",
                                    style: GoogleFonts.inter(fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.75 / 3,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    "BMI",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  Text(
                                    double.parse(bmi.toStringAsFixed(2))
                                        .toString(),
                                    style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    kategori,
                                    style: GoogleFonts.inter(fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.15 / 2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.lock),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Change Password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.15 / 2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      color: Colors.white),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(userDataProvider.notifier).logout();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Logout",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        )
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height / 5);
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 6,
      size.width,
      size.height / 5,
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
