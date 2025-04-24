import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/order_repository.dart';
import 'package:eshop/domain/usecases/order/get_local_orders_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late GetLocalOrdersUseCase usecase;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    usecase = GetLocalOrdersUseCase(mockOrderRepository);
  });

  test(
    'Should get order from the repository when Order Repository add data successfully',
        () async {
      /// Arrange
      when(() => mockOrderRepository.getLocalOrders())
          .thenAnswer((_) async => Right([tOrderDetailsModel]));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (cart) => expect(cart, [tOrderDetailsModel]),
      );
      verify(() => mockOrderRepository.getLocalOrders());
      verifyNoMoreInteractions(mockOrderRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockOrderRepository.getLocalOrders())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockOrderRepository.getLocalOrders());
    verifyNoMoreInteractions(mockOrderRepository);
  });
}
