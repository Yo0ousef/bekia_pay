import 'package:bekia_pay/features/options/domain/entities/user_entity.dart';
import 'package:bekia_pay/features/options/domain/use_cases/get_user_profile_use_case.dart';
import 'package:bekia_pay/features/options/domain/use_cases/update_user_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_cubit.freezed.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfileUseCase _getUserProfile;
  final UpdateUserProfileUseCase _updateUserProfile;

  UserProfileCubit({
    required GetUserProfileUseCase getUserProfile,
    required UpdateUserProfileUseCase updateUserProfile,
  }) : _getUserProfile = getUserProfile,
       _updateUserProfile = updateUserProfile,
       super(const UserProfileState.loading());

  Future<void> fetchUserProfile() async {
    emit(const UserProfileState.loading());
    try {
      final user = await _getUserProfile();
      if (isClosed) return;
      emit(UserProfileState.success(user));
    } catch (error) {
      if (isClosed) return;
      emit(UserProfileState.failure(error.toString()));
    }
  }

  Future<bool> updateUserProfile(UserEntity user) async {
    emit(const UserProfileState.updating());
    try {
      await _updateUserProfile(user);
      if (isClosed) return false;
      emit(UserProfileState.success(user));
      return true;
    } catch (error) {
      if (isClosed) return false;
      emit(UserProfileState.failure(error.toString()));
      return false;
    }
  }
}
