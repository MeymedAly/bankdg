import 'dart:convert';

import 'package:bankdg/ressources/api_manager.dart';
import 'package:bankdg/ressources/assets_manager.dart';
import 'package:bankdg/ressources/color_manager.dart';
import 'package:bankdg/ressources/routes_manager.dart';
import 'package:bankdg/service/crud.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formstate = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Crud _crud = Crud();

  Future<void> login() async {
    // if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    //   var response = await http.post(
    //       Uri.parse(
    //           "http://10.0.2.2:8000/api-auth/login/?next=/viewuseraccount/"),
    //       body: ({
    //         "email": emailController.text,
    //         "password": passwordController.text
    //       }));
    //   if (response.statusCode == 200) {
    //     Navigator.pop(context);
    //     Navigator.pushNamed(context, Routes.homeRoute);
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text("invalide utilisateur ")));
    //   }
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("n'existe pas")));
    // }

    var response = await _crud.postRequest(Api.loginApi,
        {"email": emailController.text, "password": passwordController.text});
    try {
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.homeRoute);
      } else {
        print("hello");
      }
    } catch (e) {}
  }

  Widget _buildBienvenue() {
    return Container(
      padding: const EdgeInsets.only(left: 35, top: 125),
      child: const Text(
        'Bienvenue \nDigiBank',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }

  Widget _buildTextFiledEmail() {
    return TextField(
      controller: emailController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email_outlined),
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  Widget _buildTextFiledMotDePasse() {
    return TextField(
      controller: passwordController,
      style: const TextStyle(),
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: "Mot de passe",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  Widget _buildSingIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Se conecter',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorManager.blueColor),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: ColorManager.blueColor,
          child: IconButton(
              color: Colors.white,
              onPressed: () async {
                await login();
                Navigator.pushNamed(context, Routes.homeRoute);
              },
              icon: const Icon(
                Icons.arrow_forward,
              )),
        )
      ],
    );
  }

  Widget _buildSingUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.registerRoute);
          },
          // ignore: sort_child_properties_last
          child: const Text(
            'Créer un compte ici',
            textAlign: TextAlign.end,
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color(0xff4c505b),
                fontSize: 15),
          ),
          style: const ButtonStyle(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageAssets.loginImage), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            _buildBienvenue(),
            Form(
              key: formstate,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            _buildTextFiledEmail(),
                            const SizedBox(
                              height: 30,
                            ),
                            _buildTextFiledMotDePasse(),
                            const SizedBox(
                              height: 30,
                            ),
                            _buildSingIn(context),
                            const SizedBox(
                              height: 40,
                            ),
                            _buildSingUp(context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
