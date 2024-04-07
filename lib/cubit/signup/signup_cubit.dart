import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:datn_npq/auth/cubit/auth_cubit.dart';
import 'package:datn_npq/auth/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../services/auth_services.dart';
import '../../theme/app_style.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Future signUp({required BuildContext ctx}) async {
    EasyLoading.show();
    final Either<String, UserCredential> userCredential =
        await AuthService.signUp(
            email: emailController.text,
            password: passwordController.text,
            ctx: ctx);
    if (userCredential is Right<String, UserCredential>) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.value.user!.uid)
          .set(UserModel(
            uid: userCredential.value.user!.uid,
            name: nameController.text,
            email: emailController.text,
            imageUrl:
                'https://media.istockphoto.com/id/1223671392/vi/vec-to/%E1%BA%A3nh-h%E1%BB%93-s%C6%A1-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-h%C3%ACnh-%C4%91%E1%BA%A1i-di%E1%BB%87n-ch%E1%BB%97-d%C3%A0nh-s%E1%BA%B5n-cho-%E1%BA%A3nh-minh-h%E1%BB%8Da-vect%C6%A1.jpg?s=612x612&w=0&k=20&c=l9x3h9RMD16-z4kNjo3z7DXVEORzkxKCMn2IVwn9liI=',
            phone: '',
          ).toMap());
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
                userCredential.value,
                textAlign: TextAlign.center,
                style: AppTextStyle.H4(color: Colors.red),
              ),
            );
          });
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    }
    EasyLoading.dismiss();
  }
}
