import 'dart:io';

import 'package:datn_npq/auth/base_screen.dart';
import 'package:datn_npq/auth/model/user_model.dart';
import 'package:datn_npq/cubit/login/login_cubit.dart';
import 'package:datn_npq/gg_services.dart';
import 'package:datn_npq/screens/admin/admin_screen.dart';
import 'package:datn_npq/screens/forgot_password_screen.dart';
import 'package:datn_npq/screens/music_screen.dart';
import 'package:datn_npq/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignInService _signInService = GoogleSignInService();

  final formKey = GlobalKey<FormState>();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/auth_bg.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Dang nhap',
                      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 400),
                    child: TextFormField(
                      controller: context.read<LoginCubit>().emailController,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value ?? 'Email không hợp lệ')) {
                          return 'Vui lòng nhập email';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          contentPadding: EdgeInsets.only(left: 16),
                          border: InputBorder.none,
                          hintText: 'Nhập email của bạn',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 400),
                    child: TextFormField(
                      controller: context.read<LoginCubit>().passwordController,
                      style: TextStyle(color: Colors.white),
                      obscureText: isShow,
                      validator: (value) {
                        if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value ?? 'Mật khẩu không hợp lệ')) {
                          return 'Vui lòng nhập mật khẩu';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(190, 186, 179, 1),
                              )),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isShow = !isShow;
                              });
                            },
                            child: isShow == false ? Image.asset('assets/images/password_show.png') : Image.asset('assets/images/password_hide.png'),
                          ),
                          contentPadding: EdgeInsets.only(left: 16, top: 10),
                          border: InputBorder.none,
                          hintText: 'Nhập mật khẩu của bạn',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 400),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(25)),
                      child: GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                    ctx: context,
                                  );
                            } else if (context.read<LoginCubit>().emailController.text == 'admin' &&
                                context.read<LoginCubit>().passwordController.text == 'admin') {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AdminScreen()), (route) => false);
                              // Navigator.of(context).pushNamedAndRemoveUntil(
                              //     AdminScreen.routeName, (route) => false);
                            }
                          },
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Đăng nhập',
                            ),
                          ))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 223, 255, 187),
                      shape: const StadiumBorder(),
                      elevation: 1,
                    ),
                    onPressed: () async {
                      final account = await _signInService.signIn();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MusicScreen(
                              user: UserModel(name: 'Quan', imageUrl: account?.photoUrl, email: account?.email, phone: '', favoriteSong: []))));
                      // Handle successful sign-in
                    },
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 50,
                    ),
                    label: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(text: 'Sign In with '),
                          TextSpan(
                            text: 'Google',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 400),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Quên mật khẩu',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Chưa có tài khoản ? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
                        },
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(color: Colors.yellow),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
