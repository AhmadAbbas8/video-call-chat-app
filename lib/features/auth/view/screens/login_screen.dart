import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_chat_app/core/extensions/ex_context.dart';
import 'package:video_chat_app/core/extensions/ex_num.dart';
import 'package:video_chat_app/features/auth/view/bloc/login_cubit/login_cubit.dart';
import 'package:video_chat_app/features/auth/view/screens/sign_up_screen.dart';

import '../../../home_feature/view/screens/home_screen.dart';
import '../../domain/remote_data_source/firebase_data_source.dart';
import '../widgets/custom_text_form_field_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<Offset> _formAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _formAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(firebaseDataSource: FirebaseDataSourceImpl()),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedBuilder(
              animation: _formAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: _formAnimation.value,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            context.pushAndRemoveUntil(const HomeScreen());
                          }
                          if (state is LoginError) {
                            context.showSnackBar(
                                SnackBar(content: Text(state.message)));
                          }
                        },
                        builder: (context, state) {
                          var cubit = context.read<LoginCubit>();
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Video Chat App',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              16.verticalSpace,
                              Text(
                                'Connect with friends and family',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              32.verticalSpace,
                              CustomTextFormFieldLogin(
                                controller: cubit.emailController,
                                hintText: 'Email or Username',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email or username';
                                  }
                                  return null;
                                },
                              ),
                              16.verticalSpace,
                              CustomTextFormFieldLogin(
                                controller: cubit.passwordController,
                                hintText: 'Password',
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              32.verticalSpace,
                              ElevatedButton(
                                onPressed: state is LoginLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.login();
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0,
                                    vertical: 16.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: state is LoginLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Login'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushReplacement(const SignUpScreen());
                                },
                                child: Text('Don\'t have an account? Sign Up'),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<UserRecord>> getAllRegisteredUsers() async {
  final app = FirebaseAdmin.instance.app();
  final auth = app?.auth();
  final listUsersResult = await auth?.listUsers();
  final users = listUsersResult?.users;
  users?.forEach(
    (element) => print(element.email ?? ''),
  );

  return users ?? [];
}
