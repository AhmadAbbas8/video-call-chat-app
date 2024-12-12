import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_chat_app/core/extensions/ex_context.dart';
import 'package:video_chat_app/features/home_feature/bloc/get_all_users_cubit.dart';
import 'package:video_chat_app/features/home_feature/data/data_source/home_firebase_data_source.dart';

import '../../../call_feature/view/screens/call_screen.dart';
import '../widget/custom_chat_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetAllUsersCubit(
          homeFirebaseDataSource: HomeFirebaseDataSourceImpl())..getAllUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat With Friends 🔥'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
            builder: (context, state) {
              if (state is GetAllUsersSuccess) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return CustomChatItem(
                      user: user,
                      isOnline: true,
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: state.users.length,
                );
              } else if (state is GetAllUsersError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
