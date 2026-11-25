import 'dart:io';

import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/domain/repos/order_repo.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/get_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepo extends Mock implements OrderRepo {}

void main() {
  late GetOrdersUseCase useCase;
  late MockOrderRepo mockOrderRepo;

  setUp(() {
    mockOrderRepo = MockOrderRepo();
    useCase = GetOrdersUseCase(repository: mockOrderRepo);
  });

  test("fetches orders successfully and delegates to repository", () async {
    when(() => mockOrderRepo.getOrders()).thenAnswer((_) async => []);
    final result = await useCase();
    expect(result, isEmpty);
    verify(() => mockOrderRepo.getOrders()).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });

  test('returns orders list when repository succeeds', () async {
    final orders = [
      OrderEntity(
        id: 'order_1',
        userId: 'user_1',
        status: 'pending',
        createdAt: DateTime.utc(2026, 1, 1),
        totalPoints: 150.0,
        items: const [],
      ),
    ];
    when(() => mockOrderRepo.getOrders()).thenAnswer((_) async => orders);

    final result = await useCase();

    expect(result, equals(orders));
    verify(() => mockOrderRepo.getOrders()).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });

  test('throws SocketException when there is no internet connection', () async {
    when(() => mockOrderRepo.getOrders())
        .thenThrow(const SocketException('No internet connection'));

    await expectLater(() => useCase(), throwsA(isA<SocketException>()));

    verify(() => mockOrderRepo.getOrders()).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });
  test("propagates FormatException when parsing/repository fails", () async {
    when(() => mockOrderRepo.getOrders())
        .thenThrow(const FormatException('Invalid order payload'));
    await expectLater(() => useCase(), throwsA(isA<FormatException>()));
    verify(() => mockOrderRepo.getOrders()).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });
}
