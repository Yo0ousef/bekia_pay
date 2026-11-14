import 'package:bekia_pay/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepo {
  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required AuthUserEntity user,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});
}
