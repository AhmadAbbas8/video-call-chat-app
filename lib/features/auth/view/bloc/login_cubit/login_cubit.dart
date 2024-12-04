import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_chat_app/features/auth/domain/remote_data_source/firebase_data_source.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.firebaseDataSource,
}) : super(LoginInitial());
final FirebaseDataSource firebaseDataSource ;
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
Future<void> login() async {
  emit(LoginLoading());
  firebaseDataSource
      .login(
        email: emailController.text,
        password: passwordController.text,
      )
      .then((value) => emit(LoginSuccess(value?.email ?? '')))
      .catchError((error) => emit(LoginError(error.toString())));
}

@override
  Future<void> close() {

    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
