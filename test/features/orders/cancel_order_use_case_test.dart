import 'dart:io';

import 'package:bekia_pay/features/orders/domain/repos/order_repo.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/cancel_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepo extends Mock implements OrderRepo {}

void main() {
  late CancelOrderUseCase useCase;
  late MockOrderRepo mockOrderRepo;
  setUp(() {
    mockOrderRepo = MockOrderRepo();
    useCase = CancelOrderUseCase(mockOrderRepo);
  });

  test('cancels order successfully and delegates to repository', () async {
    when(() => mockOrderRepo.cancelOrder('order_id')).thenAnswer((_) async {});

    await useCase('order_id');

    verify(() => mockOrderRepo.cancelOrder('order_id')).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });
  test(
    'throws ArgumentError when order id is empty and does not call repo',
    () async {
      await expectLater(() => useCase(''), throwsA(isA<ArgumentError>()));

      verifyNever(() => mockOrderRepo.cancelOrder(any()));
    },
  );
  test('throws SocketException when there is no internet connection', () async {
    when(() => mockOrderRepo.cancelOrder('order_id'))
        .thenThrow(const SocketException('No internet connection'));

    await expectLater(
      () => useCase('order_id'),
      throwsA(isA<SocketException>()),
    );

    verify(() => mockOrderRepo.cancelOrder('order_id')).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });
}
