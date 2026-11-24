import 'dart:async';
import 'dart:io';

import 'package:bekia_pay/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:bekia_pay/features/auth/presentation/cubits/sign_in_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

void main() {
  const email = 'user@example.com';
  const password = 'Password123!';
  late MockSignInUseCase signInUseCase;

  setUp(() {
    signInUseCase = MockSignInUseCase();
  });

  blocTest<SignInCubit, SignInState>(
    'emits loading then success and submits the credentials',
    build: () {
      when(() => signInUseCase(email: email, password: password))
          .thenAnswer((_) async {});
      return SignInCubit(signInUseCase);
    },
    act: (cubit) =>
        cubit.signInWithCredentials(email: email, password: password),
    expect: () => [const SignInState.loading(), const SignInState.success()],
    verify: (_) {
      verify(() => signInUseCase(email: email, password: password)).called(1);
    },
  );

  blocTest<SignInCubit, SignInState>(
    'emits loading then failure when authentication fails',
    build: () {
      when(() => signInUseCase(email: email, password: password))
          .thenThrow(Exception('Invalid credentials'));
      return SignInCubit(signInUseCase);
    },
    act: (cubit) =>
        cubit.signInWithCredentials(email: email, password: password),
    expect: () => [
      const SignInState.loading(),
      const SignInState.failure(message: 'Exception: Invalid credentials'),
    ],
  );
  blocTest<SignInCubit, SignInState>(
    'emits loading then failure when there is no internet connection',
    build: () {
      when(() => signInUseCase(email: email, password: password))
          .thenThrow(const SocketException('No internet connection'));
      return SignInCubit(signInUseCase);
    },
    act: (cubit) =>
        cubit.signInWithCredentials(email: email, password: password),
    expect: () => [
      const SignInState.loading(),
      const SignInState.failure(
        message: 'SocketException: No internet connection',
      ),
    ],
    verify: (_) {
      verify(() => signInUseCase(email: email, password: password)).called(1);
    },
  );
  blocTest<SignInCubit, SignInState>(
    'emits loading then failure when sign in times out',
    build: () {
      when(() => signInUseCase(email: email, password: password))
          .thenThrow(TimeoutException('Request timed out'));
      return SignInCubit(signInUseCase);
    },
    act: (cubit) =>
        cubit.signInWithCredentials(email: email, password: password),
    expect: () => [
      const SignInState.loading(),
      const SignInState.failure(message: 'TimeoutException: Request timed out'),
    ],
    verify: (_) {
      verify(() => signInUseCase(email: email, password: password)).called(1);
    },
  );
  blocTest<SignInCubit, SignInState>(
    'emits loading then failure when response format is invalid',
    build: () {
      when(() => signInUseCase(email: email, password: password))
          .thenThrow(const FormatException('Invalid user payload'));
      return SignInCubit(signInUseCase);
    },
    act: (cubit) =>
        cubit.signInWithCredentials(email: email, password: password),
    expect: () => [
      const SignInState.loading(),
      const SignInState.failure(
        message: 'FormatException: Invalid user payload',
      ),
    ],
    verify: (_) {
      verify(() => signInUseCase(email: email, password: password)).called(1);
    },
  );
  blocTest<SignInCubit, SignInState>(
    'emits loading then success on retry after a previous failure',
    build: () {
      var callCount = 0;
      when(() => signInUseCase(email: email, password: password))
          .thenAnswer((_) async {
            callCount++;
            if (callCount == 1) {
              throw const SocketException('No internet connection');
            }
          });
      return SignInCubit(signInUseCase);
    },
    act: (cubit) async {
      await cubit.signInWithCredentials(email: email, password: password);
      await cubit.signInWithCredentials(email: email, password: password);
    },
    expect: () => [
      const SignInState.loading(),
      const SignInState.failure(
        message: 'SocketException: No internet connection',
      ),
      const SignInState.loading(),
      const SignInState.success(),
    ],
    verify: (_) {
      verify(() => signInUseCase(email: email, password: password)).called(2);
    },
  );
}
