import 'package:bekia_pay/features/auth/domain/repos/auth_repo.dart';

class SendPasswordResetEmailUseCase {
  final AuthRepo repository;

  const SendPasswordResetEmailUseCase({required this.repository});

  Future<void> call({required String email}) =>
      repository.sendPasswordResetEmail(email: email);
}
