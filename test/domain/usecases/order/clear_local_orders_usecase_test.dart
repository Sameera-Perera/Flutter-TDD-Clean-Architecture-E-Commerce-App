import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/order_repository.dart';
import 'package:eshop/domain/usecases/order/clear_local_order_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late ClearLocalOrdersUseCase usecase;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    usecase = ClearLocalOrdersUseCase(mockOrderRepository);
  });

  test(
    'Should get Right(NoParams()) when DeliveryInfo Repository clear data successfully',
        () async {
      /// Arrange
      when(() => mockOrderRepository.clearLocalOrders())
          .thenAnswer((_) async => Right(NoParams()));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (result) => expect(result, NoParams()),
      );
      verify(() => mockOrderRepository.clearLocalOrders());
      verifyNoMoreInteractions(mockOrderRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = CacheFailure();
    when(() => mockOrderRepository.clearLocalOrders())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockOrderRepository.clearLocalOrders());
    verifyNoMoreInteractions(mockOrderRepository);
  });
}
