import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/delivery_info_repository.dart';
import 'package:eshop/domain/usecases/delivery_info/get_cached_delivery_info_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockDeliveryInfoRepository extends Mock implements DeliveryInfoRepository {}

void main() {
  late GetCachedDeliveryInfoUseCase usecase;
  late MockDeliveryInfoRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockDeliveryInfoRepository();
    usecase = GetCachedDeliveryInfoUseCase(mockProductRepository);
  });

  test(
    'Should get delivery info from the repository when DeliveryInfo Repository add data successfully',
        () async {
      /// Arrange
      when(() => mockProductRepository.getCachedDeliveryInfo())
          .thenAnswer((_) async => const Right([tDeliveryInfoModel]));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (cart) => expect(cart, [tDeliveryInfoModel]),
      );
      verify(() => mockProductRepository.getCachedDeliveryInfo());
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockProductRepository.getCachedDeliveryInfo())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockProductRepository.getCachedDeliveryInfo());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
