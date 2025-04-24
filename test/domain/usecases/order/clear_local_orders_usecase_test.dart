import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/order_repository.dart';
import 'package:eshop/domain/usecases/order/delete_local_order_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late DeleteLocalOrdersUseCase usecase;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    usecase = DeleteLocalOrdersUseCase(mockOrderRepository);
  });

  test(
    'Should get Right(NoParams()) when DeliveryInfo Repository clear data successfully',
        () async {
      /// Arrange
      when(() => mockOrderRepository.deleteLocalOrders())
          .thenAnswer((_) async => Right(NoParams()));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (result) => expect(result, NoParams()),
      );
      verify(() => mockOrderRepository.deleteLocalOrders());
      verifyNoMoreInteractions(mockOrderRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = CacheFailure();
    when(() => mockOrderRepository.deleteLocalOrders())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockOrderRepository.deleteLocalOrders());
    verifyNoMoreInteractions(mockOrderRepository);
  });
}
