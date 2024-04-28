import 'package:datn_npq/auth/base_screen.dart';
import 'package:datn_npq/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:datn_npq/theme/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.deepPurple.shade800.withOpacity(0.8),
                        Colors.deepPurple.shade200.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/forgot_pass_bg.jpg',
                            height: 300,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Text(
                              'Quên mật khẩu?',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.H4(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Nhập Email của bạn và chúng tôi sẽ gửi cho bạn link đặt lại mật khẩu',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.paragraphMedium(
                                  color: Colors.red),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 400),
                            child: TextFormField(
                              controller: context
                                  .read<ForgotPasswordCubit>()
                                  .emailController,
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
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                context
                                    .read<ForgotPasswordCubit>()
                                    .resetPassword(ctx: context);
                              }
                            },
                            child: Text(
                              'Đặt lại mật khẩu',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
