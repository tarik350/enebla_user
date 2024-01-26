// import 'package:enebla_new/auth/reset_password.dart';
// import 'package:enebla_new/auth/signup.dart';
// import 'package:enebla_new/enebla_user_home.dart';
// import 'package:enebla_new/resources/auth_methods.dart';
import 'package:enebla_new/bloc/auth/auth_bloc.dart';
import 'package:enebla_new/bloc/auth/auth_event.dart';
import 'package:enebla_new/bloc/auth/auth_state.dart';
import 'package:enebla_new/pages/home/enebla_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:enebla_new/theme/style.dart' as style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("please enter valid password(min. 6 charater)");
        }
      },
      onSaved: (Value) {
        passwordController.text = Value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final loginButton = Material(
      // elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: ElevatedButton(
        onPressed: () async {
/////LOGIN
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("email", "useremail@gmail.com");
          if (_formkey.currentState!.validate()) {
            BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(
                email: emailController.text,
                password: passwordController.text));

            // signIn(emailController.text, passwordController.text);
            // if (res == 'success') {
            //   // Fluttertoast.showToast(msg: "login successful");
            //   Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (context) => EneblaHome()));
            // } else {
            //   // Fluttertoast.showToast(msg: res);
            // }
          }
        },
        style: ElevatedButton.styleFrom(
          // minWidth: MediaQuery.of(context).size.width,

          backgroundColor: style.Style.primaryColor,
          padding: const EdgeInsets.fromLTRB(120, 15, 120, 15),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'login',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: SingleChildScrollView(
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset("lib/assets/logo1.png"),
                    ),
                    const SizedBox(
                      height: 30,
                      child: Text('Enbla'),
                    ),
                    const SizedBox(height: 45),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 8),
                    forgotpassword(context),
                    const SizedBox(height: 0),
                    Material(
                      // elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        onPressed: () async {
                          /////LOGIN
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString("email", "useremail@gmail.com");
                          if (_formkey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthLoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text));

                            // signIn(emailController.text, passwordController.text);
                            // if (res == 'success') {
                            //   // Fluttertoast.showToast(msg: "login successful");
                            //   Navigator.of(context).pushReplacement(
                            //       MaterialPageRoute(builder: (context) => EneblaHome()));
                            // } else {
                            //   // Fluttertoast.showToast(msg: res);
                            // }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          // minWidth: MediaQuery.of(context).size.width,

                          backgroundColor: style.Style.primaryColor,
                          padding: const EdgeInsets.fromLTRB(120, 15, 120, 15),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("dont have an account"),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignUp()));
                          },
                          child: const Text(
                            'sigup',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      )),
    );
  }

  // void signIn(String email, String password) async {
  Widget forgotpassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 85,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "forgot password",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => reset_password()));
        },
      ),
    );
  }
}
