import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  checkAuthentication() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(const UnAuthenticated());
    }
  }

  login(User? user) {
    emit(Authenticated(user!));
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    emit(const UnAuthenticated());
  }
}
