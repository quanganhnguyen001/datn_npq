import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:datn_npq/auth/cubit/auth_cubit.dart';
import 'package:datn_npq/services/auth_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../theme/app_style.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginCubit() : super(const LoginState());

  Future login({
    required BuildContext ctx,
  }) async {
    EasyLoading.show();
    final Either<String, UserCredential> userCredential =
        await AuthService.login(
            email: emailController.text, password: passwordController.text);
    if (userCredential is Right<String, UserCredential>) {
      ctx.read<AuthCubit>().login(userCredential.value.user);
    } else if (userCredential is Left<String, UserCredential>) {
      showDialog(
          context: ctx,
          builder: (context) {
            Future.delayed((const Duration(seconds: 2)), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Image.asset('assets/images/alert_password.png'),
              content: Text(
                'Đã có lỗi xảy ra',
                textAlign: TextAlign.center,
                style: AppTextStyle.H4(color: Colors.red),
              ),
            );
          });
      emailController.clear();
      passwordController.clear();
    }
    EasyLoading.dismiss();
  }
}
