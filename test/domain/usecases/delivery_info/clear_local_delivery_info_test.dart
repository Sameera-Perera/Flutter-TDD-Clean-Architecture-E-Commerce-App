import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/delivery_info_repository.dart';
import 'package:eshop/domain/usecases/delivery_info/clear_local_delivery_info_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockDeliveryInfoRepository extends Mock
    implements DeliveryInfoRepository {}

void main() {
  late ClearLocalDeliveryInfoUseCase usecase;
  late MockDeliveryInfoRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockDeliveryInfoRepository();
    usecase = ClearLocalDeliveryInfoUseCase(mockProductRepository);
  });

  test(
    'Should get Right(NoParams()) when DeliveryInfo Repository clear data successfully',
    () async {
      /// Arrange
      when(() => mockProductRepository.clearLocalDeliveryInfo())
          .thenAnswer((_) async => Right(NoParams()));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
        (failure) => fail('Test Fail!'),
        (result) => expect(result, NoParams()),
      );
      verify(() => mockProductRepository.clearLocalDeliveryInfo());
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = CacheFailure();
    when(() => mockProductRepository.clearLocalDeliveryInfo())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockProductRepository.clearLocalDeliveryInfo());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
