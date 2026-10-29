import 'package:bekia_pay/features/options/domain/repos/options_repo.dart';

class SignOutUseCase {
  final OptionsRepo _repository;

  const SignOutUseCase(this._repository);

  Future<void> call() => _repository.signOut();
}
