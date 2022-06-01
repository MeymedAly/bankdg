import 'package:bankdg/ressources/routes_manager.dart';
import 'package:bankdg/ressources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../phone_auth/phone_auth_cubit.dart';

// ignore: must_be_immutable
class ComfirmPhoneNumberView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final phoneNumber;
  late String otpCode;
  ComfirmPhoneNumberView({Key? key, required this.phoneNumber})
      : super(key: key);

  Widget _buildImageAndText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // const Center(
        //   child: Image(
        //     image: AssetImage(ImageAssets.splashLogo),
        //     width: 90.0,
        //   ),
        // ),
        const Text(
          AppStrings.verifierPhone,
          style: TextStyle(
              color: Color.fromARGB(255, 72, 126, 226), fontSize: 26.0),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: RichText(
            text: TextSpan(
                text:
                    'Veuillez entrer le numéro de téléphone pour vérifier votre compte ',
                style: const TextStyle(
                    color: Colors.black, fontSize: 18, height: 1.4),
                children: <TextSpan>[
                  TextSpan(
                    text: '$phoneNumber',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 47, 152, 238),
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  Widget _buildPinCodeFiled(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            borderWidth: 1,
            activeColor: const Color.fromARGB(255, 43, 156, 241),
            activeFillColor: const Color.fromARGB(255, 43, 156, 241),
            inactiveColor: const Color.fromARGB(255, 43, 156, 241),
            inactiveFillColor: Colors.white,
            selectedColor: const Color.fromARGB(255, 42, 156, 241),
            selectedFillColor: Colors.white),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (code) {
          otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _buildFerifieButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          // TDOO
          showProgressInddicator(context);
          _login(context);
        },
        // ignore: sort_child_properties_last
        child: const Text(
          AppStrings.btnVerifie,
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 40),
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

  Widget _buildPhoneVerification() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressInddicator(context);
        }
        if (state is PhoneOTPVerifier) {
          Navigator.pop(context);
          Navigator.of(context)
              .pushReplacementNamed(Routes.loginRoute, arguments: phoneNumber);
        }
        if (state is ErrorOccured) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("le code incorrect"),
              backgroundColor: Colors.black,
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
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Column(
            children: [
              _buildImageAndText(),
              const SizedBox(
                height: 32,
              ),
              _buildPinCodeFiled(context),
              const SizedBox(
                height: 50,
              ),
              _buildFerifieButton(context),
              _buildPhoneVerification(),
            ],
          ),
        ),
      ),
    );
  }
}
