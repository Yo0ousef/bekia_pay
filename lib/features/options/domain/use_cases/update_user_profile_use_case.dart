import 'package:bekia_pay/features/options/domain/entities/user_entity.dart';
import 'package:bekia_pay/features/options/domain/repos/options_repo.dart';

class UpdateUserProfileUseCase {
  final OptionsRepo _repository;

  const UpdateUserProfileUseCase(this._repository);

  Future<void> call(UserEntity user) => _repository.updateUserProfile(user);
}
