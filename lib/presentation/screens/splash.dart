import 'dart:async';
import 'package:docmehr/domain/models/userModel.dart';
import 'package:docmehr/presentation/screens/dashboard.dart';
import 'package:docmehr/presentation/screens/login.dart';
import 'package:docmehr/sqflite_db/user_db.dart';
import 'package:docmehr/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  static const routeName = 'splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _visible2 = false;

  @override
  void initState() {
    startFadeIn2();
    super.initState();
  }

  startFadeIn2() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, () async {
      setState(() {
        _visible2 = true;
      });
    });
  }

  navigate() async {
    // await UserDatabase.instance.delete(1);
    await UserDatabase.instance.readData(1).then((User? user) {
      if (user != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(DashBoard.routeName, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.background),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _visible2 ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                onEnd: navigate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(Asset.logoWithName),
                    ),
                    // new SizedBox(height: 3),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.49,
                      child: Text(StringConstants.version,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff354592),
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
