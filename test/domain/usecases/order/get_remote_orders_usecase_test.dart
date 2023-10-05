import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/order_repository.dart';
import 'package:eshop/domain/usecases/order/get_remote_orders_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockCartRepository extends Mock implements OrderRepository {}

void main() {
  late GetRemoteOrdersUseCase usecase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    usecase = GetRemoteOrdersUseCase(mockRepository);
  });

  test(
    'Should get order from the repository when Order Repository add data successfully',
        () async {
      /// Arrange
      when(() => mockRepository.getRemoteOrders())
          .thenAnswer((_) async => Right([tOrderDetailsModel]));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (cart) => expect(cart, [tOrderDetailsModel]),
      );
      verify(() => mockRepository.getRemoteOrders());
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.getRemoteOrders())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getRemoteOrders());
    verifyNoMoreInteractions(mockRepository);
  });
}
