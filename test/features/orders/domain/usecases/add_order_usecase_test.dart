import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/features/orders/domain/repositories/order_repository.dart';
import 'package:eshop/features/orders/domain/usecases/order/add_order_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/constant_objects.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late AddOrderUseCase usecase;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    usecase = AddOrderUseCase(mockOrderRepository);
  });

  test(
    'Should get order from the repository when Order Repository add data successfully',
        () async {
      /// Arrange
      when(() => mockOrderRepository.addOrder(tOrderDetailsModel))
          .thenAnswer((_) async => Right(tOrderDetailsModel));

      /// Act
      final result = await usecase(tOrderDetailsModel);

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (cart) => expect(cart, tOrderDetailsModel),
      );
      verify(() => mockOrderRepository.addOrder(tOrderDetailsModel));
      verifyNoMoreInteractions(mockOrderRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockOrderRepository.addOrder(tOrderDetailsModel))
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tOrderDetailsModel);

    /// Assert
    expect(result, Left(failure));
    verify(() => mockOrderRepository.addOrder(tOrderDetailsModel));
    verifyNoMoreInteractions(mockOrderRepository);
  });
}
