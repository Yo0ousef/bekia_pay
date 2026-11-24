import 'package:bekia_pay/features/auth/domain/errors/auth_failure.dart';
import 'package:bekia_pay/features/auth/domain/repos/auth_repo.dart';
import 'package:bekia_pay/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  const email = 'user@example.com';
  const password = 'Password123!';
  late MockAuthRepo authRepo;
  late SignInUseCase useCase;

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = SignInUseCase(repository: authRepo);
  });

  test('completes when the repository signs in successfully', () async {
    when(() => authRepo.signIn(email: email, password: password))
        .thenAnswer((_) async {});

    await useCase(email: email, password: password);

    verify(() => authRepo.signIn(email: email, password: password)).called(1);
  });

  test('propagates AuthFailure for a wrong password', () async {
    const failure = AuthFailure('Invalid email or password.');
    when(() => authRepo.signIn(email: email, password: password))
        .thenAnswer((_) => Future<void>.error(failure));

    await expectLater(
      useCase(email: email, password: password),
      throwsA(
        isA<AuthFailure>().having(
          (error) => error.message,
          'message',
          failure.message,
        ),
      ),
    );
  });

  test('propagates AuthFailure for a network error', () async {
    const failure = AuthFailure('No internet connection');
    when(() => authRepo.signIn(email: email, password: password))
        .thenAnswer((_) => Future<void>.error(failure));

    await expectLater(
      useCase(email: email, password: password),
      throwsA(
        isA<AuthFailure>().having(
          (error) => error.message,
          'message',
          failure.message,
        ),
      ),
    );
  });
}
