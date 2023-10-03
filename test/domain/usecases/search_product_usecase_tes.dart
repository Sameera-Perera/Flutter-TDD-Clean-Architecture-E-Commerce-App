// import 'package:dartz/dartz.dart';
// import 'package:eshop/core/usecases/usecase.dart';
// import 'package:eshop/domain/entities/product/product.dart';
// import 'package:eshop/domain/repositories/product_repository.dart';
// import 'package:eshop/domain/usecases/product/search_product_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// import '../../fixtures/constant_objects.dart';
//
// class MockNumberProductRepository extends Mock implements ProductRepository {}
//
// void main() {
//   late SearchProductUseCase usecase;
//   late MockNumberProductRepository mockNumberProductRepository;
//
//   setUp(() {
//     mockNumberProductRepository = MockNumberProductRepository();
//     usecase = SearchProductUseCase(mockNumberProductRepository);
//   });
//
//   test(
//     'should get products from the repository',
//     () async {
//       // arrange
//       const params = SearchProductParams(keyword: "Text");
//       when(() => mockNumberProductRepository.searchProducts(params))
//           .thenAnswer((_) async => const Right(tProductModelList));
//       // act
//       final result = await usecase(params);
//       // assert
//       expect(result, const Right(tProductModelList));
//       verify(() => mockNumberProductRepository.searchProducts(params));
//       verifyNoMoreInteractions(mockNumberProductRepository);
//     },
//   );
// }
