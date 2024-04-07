import 'package:datn_npq/auth/base_screen.dart';
import 'package:datn_npq/cubit/signup/signup_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Đăng Ký'),
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
                  controller: context.read<SignupCubit>().nameController,
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên';
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
                    hintText: 'Nhập tên của bạn',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 400),
                child: TextFormField(
                  controller: context.read<SignupCubit>().emailController,
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
                  controller: context.read<SignupCubit>().passwordController,
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
                  if (formKey.currentState!.validate()) {
                    context.read<SignupCubit>().signUp(ctx: context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text('Đăng ký'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.yellow,
                      child: Text('Đã có tài khoản ? '),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Text('Đăng Nhập'),
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
