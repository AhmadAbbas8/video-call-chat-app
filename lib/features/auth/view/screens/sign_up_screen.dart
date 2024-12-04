import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_chat_app/core/extensions/ex_context.dart';
import 'package:video_chat_app/core/extensions/ex_num.dart';
import 'package:video_chat_app/features/auth/domain/remote_data_source/firebase_data_source.dart';
import 'package:video_chat_app/features/auth/view/bloc/sign_up_cubit/sign_up_cubit.dart';
import 'package:video_chat_app/features/home_feature/view/screens/home_screen.dart';
import '../widgets/custom_text_form_field_login.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
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
      create: (_) => SignUpCubit(firebaseDataSource: FirebaseDataSourceImpl()),
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
                    child: BlocConsumer<SignUpCubit, SignUpState>(
                      listenWhen: (previous, current) => previous != current,
                      listener: (context, state) {
                        if (state is SignUpSuccess) {
                          context.pushAndRemoveUntil(
                            const HomeScreen(),
                          );
                        }
                        if (state is SignUpError) {
                          context.showSnackBar(SnackBar(
                            content: Text(state.message),
                          ));
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<SignUpCubit>();
                        return SingleChildScrollView(
                          child: Column(
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
                                hintText: 'Name',
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                controller: cubit.nameController,
                              ),
                              16.verticalSpace,
                              CustomTextFormFieldLogin(
                                controller: cubit.emailController,
                                hintText: 'Email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
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
                                onPressed: state is SignUpLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.signUp();
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
                                child: state is SignUpLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Sign Up'),
                              ),
                              TextButton(
                                onPressed: () => context
                                    .pushReplacement(const LoginScreen()),
                                child: Text('Already have an account? Login'),
                              ),
                            ],
                          ),
                        );
                      },
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
