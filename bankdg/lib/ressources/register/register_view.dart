import 'package:bankdg/model/register_model.dart';
import 'package:bankdg/ressources/assets_manager.dart';
import 'package:bankdg/ressources/routes_manager.dart';
import 'package:bankdg/service/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _registration() async {
    //final String id;
    final String firstVal = firstController.text;
    final String lastVal = lastController.text;
    final String emailVal = emailController.text;
    final String paswordVal = passwordController.text;
    RegisterApi registerApi = RegisterApi(
        firstName: firstVal,
        lastName: lastVal,
        email: emailVal,
        password: paswordVal);
    var provider = Provider.of<DataClass>(context, listen: false);
    await provider.postData(registerApi);
    if (provider.isBack) {
      Navigator.pushNamed(context, Routes.loginRoute);
    }
    ;
    // if (provider.loading) {
    //
    // }
  }

  Widget _buildCreeAcount() {
    return Container(
      padding: const EdgeInsets.only(left: 35, top: 90),
      child: const Text(
        'Créer un compte',
        style: TextStyle(color: Colors.white, fontSize: 33),
      ),
    );
  }

  _buildTextFiledName() {
    return TextFormField(
      controller: firstController,
      validator: (value) {},
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          //prefixIcon: const Icon(Icons.abc_sharp),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "Nom",
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  Widget _buildTextFliledLastName() {
    return TextField(
      controller: lastController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "Prénom",
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  Widget _buildTextFiledEmail() {
    return TextField(
      controller: emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "Email",
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  Widget _buildTextFiledMotDePasse() {
    return TextField(
      controller: passwordController,
      style: TextStyle(color: Colors.white),
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "Mot de passe",
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }

  Widget _buildRowRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Créer',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xff4c505b),
          child: IconButton(
              color: Colors.white,
              onPressed: () {
                _registration();
                //var provider;
                // if (provider.isBack) {
                //   // ignore: use_build_context_synchronously
                //   Navigator.pushNamed(context, Routes.loginRoute);
                // }
                Navigator.pushNamed(context, Routes.homeRoute);
              },
              icon: const Icon(
                Icons.arrow_forward,
              )),
        )
      ],
    );
  }

  Widget _buildRowLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.loginRoute);
          },
          // ignore: sort_child_properties_last
          child: const Text(
            'Se connecter',
            //textAlign: TextAlign.left,
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 18),
          ),
          style: ButtonStyle(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageAssets.registerImage), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildCreeAcount(),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          _buildTextFiledName(),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildTextFliledLastName(),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildTextFiledEmail(),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildTextFiledMotDePasse(),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildRowRegister(),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildRowLogin(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
