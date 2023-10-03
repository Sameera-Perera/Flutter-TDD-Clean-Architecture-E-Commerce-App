// import 'package:dartz/dartz.dart';
// import 'package:eshop/core/usecases/usecase.dart';
// import 'package:eshop/domain/entities/product/product.dart';
// import 'package:eshop/domain/repositories/product_repository.dart';
// import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// import '../../fixtures/constant_objects.dart';
//
// class MockNumberProductRepository extends Mock implements ProductRepository {}
//
// void main() {
//   late GetProductUseCase usecase;
//   late MockNumberProductRepository mockNumberProductRepository;
//
//   setUp(() {
//     mockNumberProductRepository = MockNumberProductRepository();
//     usecase = GetProductUseCase(mockNumberProductRepository);
//   });
//
//   test(
//     'should get products from the repository',
//     () async {
//       // arrange
//       when(() => mockNumberProductRepository.getProducts())
//           .thenAnswer((_) async => const Right(tProductModelList));
//       // act
//       final result = await usecase(NoParams());
//       // assert
//       expect(result, const Right(tProductModelList));
//       verify(() => mockNumberProductRepository.getProducts());
//       verifyNoMoreInteractions(mockNumberProductRepository);
//     },
//   );
// }
