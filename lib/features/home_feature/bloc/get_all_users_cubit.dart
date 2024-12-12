import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_chat_app/features/home_feature/data/data_source/home_firebase_data_source.dart';

import '../data/models/user_model.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit({required this.homeFirebaseDataSource})
      : super(GetAllUsersLoading());

  final HomeFirebaseDataSource homeFirebaseDataSource;

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoading());
    homeFirebaseDataSource
        .getAllUsers()
        .then((value) => emit(GetAllUsersSuccess(value)))
        .catchError((error) => emit(GetAllUsersError(error.toString())));
  }
}
