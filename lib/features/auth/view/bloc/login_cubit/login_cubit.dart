import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_chat_app/core/constants.dart';
import 'package:video_chat_app/features/auth/domain/remote_data_source/firebase_data_source.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.firebaseDataSource,
  }) : super(LoginInitial());
  final FirebaseDataSource firebaseDataSource;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    emit(LoginLoading());
    firebaseDataSource
        .login(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      onUserLogin(value!.uid, emailController.text);
      emit(LoginSuccess(value?.email ?? ''));
    }).catchError((error) => emit(LoginError(error.toString())));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void onUserLogin(String userId, String userName) async {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: AppConstants.appID,
      appSign: AppConstants.appSign,
      userID: userId,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }
}
