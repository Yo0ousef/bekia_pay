import 'package:bekia_pay/features/options/domain/entities/user_entity.dart';

abstract class OptionsRepo {
  Future<UserEntity> getUserProfile();

  Future<void> updateUserProfile(UserEntity user);

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> signOut();
}
