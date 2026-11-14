import 'package:bekia_pay/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bekia_pay/features/auth/data/models/auth_user_model.dart';
import 'package:bekia_pay/features/auth/domain/entities/auth_user_entity.dart';
import 'package:bekia_pay/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepoImpl(this.remoteDataSource);

  @override
  Future<void> signIn({required String email, required String password}) =>
      remoteDataSource.signIn(email: email, password: password);

  @override
  Future<void> signUp({
    required AuthUserEntity user,
    required String password,
  }) => remoteDataSource.signUp(
    user: AuthUserModel.fromEntity(user),
    password: password,
  );

  @override
  Future<void> sendPasswordResetEmail({required String email}) =>
      remoteDataSource.sendPasswordResetEmail(email: email);
}
