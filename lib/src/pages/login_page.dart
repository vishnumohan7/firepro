import 'package:firepro/src/cubit/authentication/authentication_cubit.dart';
import 'package:firepro/src/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool? isCheckBoxSelected = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
  create: (context) => AuthenticationCubit(),
  child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color(0xffbd5d80),
                Color(0xff513b5d),
              ], begin: Alignment.topCenter, end: Alignment(0.8, 1))),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    "Login",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome  back! Please login \n           to your account",
                    style:
                    GoogleFonts.inter(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(7))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(7))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isCheckBoxSelected,
                          onChanged: (isSelected) {
                            setState(() {
                              isCheckBoxSelected = isSelected;
                            });
                          }),
                      Text(
                        "Remember Me",
                        style: GoogleFonts.inter(
                            fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if (state is AuthenticationSuccess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomePage()));
                      } else if (state is AuthenticationError) {
                        String errorMessage = state.errorMessage;
                        showDialog(
                            context: context,
                            builder: (
                                _,
                                ) {
                              return AlertDialog(
                                title: const Text("Login Failed"),
                                content: Text("$errorMessage"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"))
                                ],
                              );
                            });
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthenticationLoading) {
                        return Center(child: CupertinoActivityIndicator());
                      }
                      return ElevatedButton(
                          onPressed: () {
                            context.read<AuthenticationCubit>().loginUser(
                                _emailController.text.trim(),
                                _passwordController.text);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 105.0, right: 105, top: 15, bottom: 15),
                            child: Text(
                              "Login",
                              style: GoogleFonts.inter(
                                  color: Color(0xff513b5d), fontSize: 20),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
),
    );
  }
}
