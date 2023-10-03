// import 'package:dartz/dartz.dart';
// import 'package:eshop/domain/repositories/product_repository.dart';
// import 'package:eshop/domain/usecases/product/filter_product_usecase.dart';
// import 'package:eshop/domain/usecases/product/search_product_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// import '../../fixtures/constant_objects.dart';
//
// class MockNumberProductRepository extends Mock implements ProductRepository {}
//
// void main() {
//   late FilterProductUseCase usecase;
//   late MockNumberProductRepository mockNumberProductRepository;
//
//   setUp(() {
//     mockNumberProductRepository = MockNumberProductRepository();
//     usecase = FilterProductUseCase(mockNumberProductRepository);
//   });
//
//   test(
//     'should get products from the repository',
//         () async {
//       // arrange
//       const params = FilterProductParams(keyword: "Text", category: "Text", minPrice: 0, maxPrice: 1000);
//       when(() => mockNumberProductRepository.filterProducts(params))
//           .thenAnswer((_) async => const Right(tProductModelList));
//       // act
//       final result = await usecase(params);
//       // assert
//       expect(result, const Right(tProductModelList));
//       verify(() => mockNumberProductRepository.filterProducts(params));
//       verifyNoMoreInteractions(mockNumberProductRepository);
//     },
//   );
// }
