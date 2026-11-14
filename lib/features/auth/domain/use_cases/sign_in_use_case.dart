import 'package:bekia_pay/features/auth/domain/repos/auth_repo.dart';

class SignInUseCase {
  final AuthRepo repository;

  const SignInUseCase({required this.repository});

  Future<void> call({required String email, required String password}) =>
      repository.signIn(email: email, password: password);
}
