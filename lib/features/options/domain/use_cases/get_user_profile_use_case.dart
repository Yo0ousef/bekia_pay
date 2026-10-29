import 'package:bekia_pay/features/options/domain/entities/user_entity.dart';
import 'package:bekia_pay/features/options/domain/repos/options_repo.dart';

class GetUserProfileUseCase {
  final OptionsRepo _repository;

  const GetUserProfileUseCase(this._repository);

  Future<UserEntity> call() => _repository.getUserProfile();
}
