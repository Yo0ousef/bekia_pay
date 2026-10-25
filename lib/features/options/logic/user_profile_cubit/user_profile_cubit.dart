import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/options/data/options_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_cubit.freezed.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final OptionsRepo _repo;

  UserProfileCubit(this._repo) : super(const UserProfileState.loading()) {
    getUserProfile();
  }

  void getUserProfile() async {
    final result = await _repo.getUserProfile();
    result.when(
      success: (data) {
        emit(UserProfileState.success(data));
      },
      failure: (message) {
        emit(UserProfileState.failure(message));
      },
    );
  }
}
