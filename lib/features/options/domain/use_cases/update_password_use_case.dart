import 'package:bekia_pay/features/options/domain/repos/options_repo.dart';

class UpdatePasswordUseCase {
  final OptionsRepo _repository;

  const UpdatePasswordUseCase(this._repository);

  Future<void> call({
    required String currentPassword,
    required String newPassword,
  }) => _repository.updatePassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );
}
