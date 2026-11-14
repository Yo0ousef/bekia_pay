import 'package:bekia_pay/features/auth/domain/entities/auth_user_entity.dart';
import 'package:bekia_pay/features/auth/domain/repos/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo repository;

  const SignUpUseCase({required this.repository});

  Future<void> call({required AuthUserEntity user, required String password}) =>
      repository.signUp(user: user, password: password);
}
