import 'package:datn_npq/auth/base_screen.dart';
import 'package:datn_npq/cubit/login/login_cubit.dart';
import 'package:datn_npq/screens/admin/admin_screen.dart';
import 'package:datn_npq/screens/forgot_password_screen.dart';
import 'package:datn_npq/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Đăng Nhập'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 400),
                child: TextFormField(
                  controller: context.read<LoginCubit>().emailController,
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value ?? 'Email không hợp lệ')) {
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
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 400),
                child: TextFormField(
                  controller: context.read<LoginCubit>().passwordController,
                  style: TextStyle(color: Colors.black),
                  obscureText: isShow,
                  validator: (value) {
                    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                        .hasMatch(value ?? 'Mật khẩu không hợp lệ')) {
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
                      child: isShow == false
                          ? Image.asset('assets/images/password_show.png')
                          : Image.asset('assets/images/password_hide.png'),
                    ),
                    contentPadding: EdgeInsets.only(left: 16, top: 10),
                    border: InputBorder.none,
                    hintText: 'Nhập mật khẩu của bạn',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()));
                },
                child: Container(
                  color: Colors.blue,
                  child: Text('Quên mật khẩu'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.green),
                child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                              ctx: context,
                            );
                      } else if (context
                                  .read<LoginCubit>()
                                  .emailController
                                  .text ==
                              'admin' &&
                          context.read<LoginCubit>().passwordController.text ==
                              'admin') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminScreen()));
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     AdminScreen.routeName, (route) => false);
                      }
                    },
                    child: Text('Đăng nhập')),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.yellow,
                    child: Text('Chưa có tài khoản ? '),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Text('Đăng ký'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
