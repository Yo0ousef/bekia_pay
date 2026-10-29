import 'package:bekia_pay/features/options/data/data_sources/options_remote_data_source.dart';
import 'package:bekia_pay/features/options/data/models/user_model.dart';
import 'package:bekia_pay/features/options/domain/entities/user_entity.dart';
import 'package:bekia_pay/features/options/domain/repos/options_repo.dart';

class OptionsRepoImpl implements OptionsRepo {
  final OptionsRemoteDataSource _remoteDataSource;

  const OptionsRepoImpl(this._remoteDataSource);

  @override
  Future<UserEntity> getUserProfile() async {
    final json = await _remoteDataSource.getUserProfile();
    return UserModel.fromJson(json).toEntity();
  }

  @override
  Future<void> updateUserProfile(UserEntity user) {
    final model = UserModel.fromEntity(user);
    return _remoteDataSource.updateUserProfile(
      userId: model.id,
      profile: model.toProfileUpdateJson(),
    );
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) => _remoteDataSource.updatePassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );

  @override
  Future<void> signOut() => _remoteDataSource.signOut();
}
