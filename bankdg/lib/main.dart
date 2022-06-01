import 'package:bankdg/ressources/routes_manager.dart';
import 'package:bankdg/service/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataClass()),
      ],
      child: MyApp(
        appRouter: RouteGenerator(),
      )));

  // FirebaseAuth.instance.authStateChanges().listen((user) {
  //   if (user == null) {
  //     initialRoute = Routes.phoneRoute;
  //   } else {
  //     initialRoute = Routes.loginRoute;
  //   }
  // });

  // runApp(MyApp(
  // //     MultiProvider(providers: [
  // //   ChangeNotifierProvider(create: (_)=>DataClass()),

  // // ],

  //   appRouter: RouteGenerator(),

  // ));
}

class MyApp extends StatelessWidget {
  final RouteGenerator appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
