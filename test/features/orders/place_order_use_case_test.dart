import 'dart:io';

import 'package:bekia_pay/features/orders/domain/entities/order_item_request.dart';
import 'package:bekia_pay/features/orders/domain/repos/order_repo.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/place_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepo extends Mock implements OrderRepo {}

void main() {
  late MockOrderRepo mockOrderRepo;
  late PlaceOrderUseCase useCase;
  late List<OrderItemRequest> sampleItems;

  setUp(() {
    mockOrderRepo = MockOrderRepo();
    useCase = PlaceOrderUseCase(repository: mockOrderRepo);
    sampleItems = [
      const OrderItemRequest(productId: 'product_1', quantity: 2),
      const OrderItemRequest(productId: 'product_2', quantity: 1),
    ];
  });

  test("places order successfully and delegates to repository", () async {
    when(() => mockOrderRepo.placeOrder(items: any(named: 'items')))
        .thenAnswer((_) async {});
    await useCase(items: sampleItems);
    verify(() => mockOrderRepo.placeOrder(items: sampleItems)).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });

  test(
    "throws ArgumentError when items list is empty and does not call repo",
    () async {
      await expectLater(
        () => useCase(items: []),
        throwsA(isA<ArgumentError>()),
      );
      verifyNever(() => mockOrderRepo.placeOrder(items: any(named: 'items')));
    },
  );

  test('propagates exception when repository fails to place order', () async {
    when(() => mockOrderRepo.placeOrder(items: any(named: 'items')))
        .thenThrow(Exception('Failed to place order'));

    await expectLater(
      () => useCase(items: sampleItems),
      throwsA(isA<Exception>()),
    );

    verify(() => mockOrderRepo.placeOrder(items: sampleItems)).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });
  test('throws SocketException when there is no internet connection', () async {
    when(() => mockOrderRepo.placeOrder(items: any(named: 'items')))
        .thenThrow(const SocketException('No internet connection'));

    await expectLater(
      () => useCase(items: sampleItems),
      throwsA(isA<SocketException>()),
    );

    verify(() => mockOrderRepo.placeOrder(items: sampleItems)).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });

  test('propagates FormatException when response/payload is invalid', () async {
    when(() => mockOrderRepo.placeOrder(items: any(named: 'items')))
        .thenThrow(const FormatException('Invalid order response'));

    await expectLater(
      () => useCase(items: sampleItems),
      throwsA(isA<FormatException>()),
    );

    verify(() => mockOrderRepo.placeOrder(items: sampleItems)).called(1);
    verifyNoMoreInteractions(mockOrderRepo);
  });
}
