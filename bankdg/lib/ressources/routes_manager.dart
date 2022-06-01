import 'package:bankdg/phone_auth/phone_auth_cubit.dart';
import 'package:bankdg/ressources/consult/consult.dart';
import 'package:bankdg/ressources/home/home_view.dart';
import 'package:bankdg/ressources/login/login_view.dart';
import 'package:bankdg/ressources/phoneNomber/phonenumber_view.dart';
import 'package:bankdg/ressources/phoneconfirme/confirmnumber.dart';
import 'package:bankdg/ressources/register/register_view.dart';
import 'package:bankdg/ressources/strings_manager.dart';
import 'package:bankdg/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String phoneRoute = '/phone';
  static const String confirmPhoneRoute = '/confirmPhone';
  static const String homeRoute = '/home';
  static const String consultRoute = '/home';
}

class RouteGenerator {
  PhoneAuthCubit? phoneAuthCubit;
  RouteGenerator() {
    phoneAuthCubit = PhoneAuthCubit();
  }

//Route<dynamic> getRoute(RouteSettings settings)
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => SplashView(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );

      case Routes.phoneRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: PhoneNumberView(),
          ),
        );
      case Routes.confirmPhoneRoute:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: ComfirmPhoneNumberView(phoneNumber: phoneNumber),
          ),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterView(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      default:
        return unDefindRoute();
    }
  }

  //static Route<dynamic> unDefindRoute()
  static Route<dynamic> unDefindRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(AppStrings.pageNonTrouvable)),
              body: const Center(
                child: Text(AppStrings.pageNonTrouvable),
              ),
            ));
  }
}
