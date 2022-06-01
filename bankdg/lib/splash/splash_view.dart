import 'dart:io';
import 'package:bankdg/ressources/assets_manager.dart';
import 'package:bankdg/ressources/routes_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late String initialRoutes;

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    //Navigator.of(context).pop();
    super.initState();
    // _startDelay();

    Future.delayed(const Duration(seconds: 12), () {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          Navigator.pushNamed(context, Routes.phoneRoute);
          //initialRoutes = Routes.phoneRoute;
        } else {
          Navigator.pushNamed(context, Routes.loginRoute);
        }
      });
      // Navigator.pushNamed(context, Routes.loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.moneysplash,
              height: 200,
            ),
            const SizedBox(
              height: 50,
            ),
            if (Platform.isIOS)
              const CupertinoActivityIndicator(
                radius: 20,
              )
            else
              const CircularProgressIndicator(
                color: Colors.white,
              )
          ],
        ),
      ),
    );
    ;
  }
}
