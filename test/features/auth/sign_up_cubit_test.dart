import 'dart:io';

import 'package:bekia_pay/features/auth/domain/entities/auth_user_entity.dart';
import 'package:bekia_pay/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:bekia_pay/features/auth/presentation/cubits/sign_up_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const user = AuthUserEntity(
    fullName: 'Test User',
    role: 'user',
    city: 'Cairo',
    phone: '+201000000000',
    email: 'user@example.com',
    floor: '2',
    street: 'Main Street',
    governorate: 'Cairo',
    houseNumber: '10',
    apartmentNumber: '4',
    pointsBalance: 0,
  );
  const password = 'Password123!';
  late MockSignUpUseCase signUpUseCase;

  setUp(() {
    signUpUseCase = MockSignUpUseCase();
  });

  blocTest<SignUpCubit, SignUpState>(
    'emits loading then success and submits the user and password',
    build: () {
      when(() => signUpUseCase(user: user, password: password))
          .thenAnswer((_) async {});
      return SignUpCubit(signUpUseCase);
    },
    act: (cubit) => cubit.signUpWithUser(user: user, password: password),
    expect: () => [const SignUpState.loading(), const SignUpState.success()],
    verify: (_) {
      verify(() => signUpUseCase(user: user, password: password)).called(1);
    },
  );

  blocTest<SignUpCubit, SignUpState>(
    'emits loading then failure when account creation fails',
    build: () {
      when(() => signUpUseCase(user: user, password: password))
          .thenThrow(Exception('Email already used'));
      return SignUpCubit(signUpUseCase);
    },
    act: (cubit) => cubit.signUpWithUser(user: user, password: password),
    expect: () => [
      const SignUpState.loading(),
      const SignUpState.failure(message: 'Exception: Email already used'),
    ],
  );
  blocTest<SignUpCubit, SignUpState>(
    'emits loading then failure when there is no internet connection',
    build: () {
      when(() => signUpUseCase(user: user, password: password))
          .thenThrow(const SocketException('No internet connection'));
      return SignUpCubit(signUpUseCase);
    },
    act: (cubit) => cubit.signUpWithUser(user: user, password: password),
    expect: () => [
      const SignUpState.loading(),
      const SignUpState.failure(
        message: 'SocketException: No internet connection',
      ),
    ],
    verify: (_) {
      verify(() => signUpUseCase(user: user, password: password)).called(1);
    },
  );
}
