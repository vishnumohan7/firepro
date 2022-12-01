import 'package:firepro/src/cubit/authentication/authentication_cubit.dart';
import 'package:firepro/src/models/user_model.dart';
import 'package:firepro/src/pages/home_page.dart';
import 'package:firepro/src/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                  "Signup",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
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
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: "Name",
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
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: "Address",
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
                // Row(
                //   children: [
                //     Checkbox(
                //         value: isCheckBoxSelected,
                //         onChanged: (isSelected) {
                //           setState(() {
                //             isCheckBoxSelected = isSelected;
                //           });
                //         }),
                //     Text(
                //       "Remember Me",
                //       style: GoogleFonts.inter(
                //           fontSize: 18, color: Colors.white),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 15,
                ),
                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    } else if (state is AuthenticationError) {
                      String errorMessage = state.errorMessage;
                      showDialog(
                          context: context,
                          builder: (
                            _,
                          ) {
                            return AlertDialog(
                              title: const Text("Signup Failed"),
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
                          UserModel user = UserModel(
                              email: _emailController.text,
                              address: _addressController.text,
                              name: _nameController.text,
                              password: _passwordController.text);
                          context.read<AuthenticationCubit>().createUser(user);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 100.0, right: 100, top: 15, bottom: 15),
                          child: Text(
                            "Signup",
                            style: GoogleFonts.inter(
                                color: Color(0xff513b5d), fontSize: 16),
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
);
  }
}
