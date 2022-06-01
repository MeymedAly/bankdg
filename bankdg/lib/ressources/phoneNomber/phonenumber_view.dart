import 'package:bankdg/ressources/assets_manager.dart';
import 'package:bankdg/ressources/color_manager.dart';
import 'package:bankdg/ressources/routes_manager.dart';
import 'package:bankdg/ressources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../phone_auth/phone_auth_cubit.dart';

class PhoneNumberView extends StatelessWidget {
  PhoneNumberView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  late String phoneNumber;

  Widget _buildImageAndText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Center(
            // child: Image(
            //   image: AssetImage(ImageAssets.splashLogo),
            //   width: 100.0,
            // ),
            ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          AppStrings.WaIsphoneNumber,
          style: TextStyle(
              color: Color.fromARGB(255, 72, 126, 226), fontSize: 26.0),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: const Text(
            AppStrings.EnterphoneNumber,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPhoneFormFiled() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
                border: Border.all(color: ColorManager.blueColor),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: Text(
              generateContryCode() + ' +222',
              style: const TextStyle(fontSize: 18, letterSpacing: 2.0),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: TextFormField(
              autofocus: true,
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: const InputDecoration(border: InputBorder.none),
              cursorColor: Colors.black,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppStrings.PlaseEnterphoneNumber;
                } else if (value.length < 8) {
                  return AppStrings.phoneNumberNotValide;
                }
                return null;
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }

  String generateContryCode() {
    String countryCode = 'mr';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).submitPhonenumber(phoneNumber);
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          // TDOO
          //Navigator.pushNamed(context, Routes.confirmPhoneRoute);
          showProgressInddicator(context);
          _register(context);
        },
        // ignore: sort_child_properties_last
        child: const Text(
          AppStrings.btnenvoyer,
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(110, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            )),
      ),
    );
  }

  void showProgressInddicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  Widget _buildPhoneNumberSubmited() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressInddicator(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          Navigator.of(context)
              .pushNamed(Routes.confirmPhoneRoute, arguments: phoneNumber);
        }
        if (state is ErrorOccured) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("le code est incorrecte"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _phoneFormKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
              child: Column(
                children: [
                  _buildImageAndText(),
                  const SizedBox(
                    height: 90,
                  ),
                  _buildPhoneFormFiled(),
                  const SizedBox(
                    height: 90,
                  ),
                  _buildNextButton(context),
                  _buildPhoneNumberSubmited(),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
