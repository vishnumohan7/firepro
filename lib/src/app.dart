import 'package:firepro/src/cubit/authentication/authentication_cubit.dart';
import 'package:firepro/src/pages/login_page.dart';
import 'package:firepro/src/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blue
        ),
        home: LoginPage(),
      ),
    );
  }
}
