import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_chat_app/features/auth/domain/remote_data_source/firebase_data_source.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../../../../core/constants.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.firebaseDataSource,
  }) : super(SignUpInitial());
  final FirebaseDataSource firebaseDataSource;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> signUp() async {
    emit(SignUpLoading());
    firebaseDataSource
        .signUp(
          email: emailController.text,
          password: passwordController.text,
      name: nameController.text,
        )
        .then((value) {
      onUserLogin(value!.uid, emailController.text);
      emit(SignUpSuccess(value?.email ?? ''));
    })
        .catchError((error) => emit(SignUpError(error.toString())));
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
