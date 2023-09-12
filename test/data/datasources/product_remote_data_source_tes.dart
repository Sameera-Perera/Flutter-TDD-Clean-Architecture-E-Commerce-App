// import 'dart:convert';
//
// import 'package:eshop/data/data_sources/remote/product_remote_data_source.dart';
// import 'package:eshop/data/models/product/product_model.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mocktail/mocktail.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import '../../fixtures/constent_objects.dart';
// import '../../fixtures/fixture_reader.dart';
//
// class MockHttpClient extends Mock implements http.Client {}
//
// void main() {
//   late ProductRemoteDataSourceImpl dataSource;
//   late MockHttpClient mockHttpClient;
//
//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
//   });
//
//   void setUpMockHttpClientSuccess200() {
//     when(() =>
//             mockHttpClient.get(any, headers: any(named: 'headers')))
//         .thenAnswer((_) async => http.Response(fixture('products.json'), 200));
//   }
//
//   void setUpMockHttpClientFailure404() {
//     when(() =>
//             mockHttpClient.get(Uri.parse('https://base-domain.com/products')))
//         .thenAnswer((_) async => http.Response('Something went wrong', 404));
//   }
//
//   group('getProducts', () {
//     // final tProducts =
//     //     productModelFromJson(json.decode(fixture('products.json')));
//
//     test(
//       '''should perform a GET request on a URL with number
//        being the endpoint and with application/json header''',
//       () async {
//         // arrange
//         // setUpMockHttpClientSuccess200();
//         when(() =>
//             mockHttpClient.get(Uri.parse('https://base-domain.com/products'), headers: {
//               'Content-Type': 'application/json',
//             },))
//             .thenAnswer((_) async => http.Response(fixture('products.json'), 200));
//         // when(() => dataSource.getProducts()).thenAnswer((_) async => tProductModelList);
//         // act
//         // dataSource.getProducts();
//         // // assert
//         // verify(() =>
//         //     mockHttpClient.get(Uri.parse('https://base-domain.com/products')));
//         // expect(await fetchAlbum(client), isA<Album>());
//       },
//     );
//     //
//     //   test(
//     //     'should return NumberTrivia when the response code is 200 (success)',
//     //     () async {
//     //       // arrange
//     //       setUpMockHttpClientSuccess200();
//     //       // act
//     //       final result = await dataSource.getConcreteNumberTrivia(tNumber);
//     //       // assert
//     //       expect(result, equals(tNumberTriviaModel));
//     //     },
//     //   );
//     //
//     //   test(
//     //     'should throw a ServerException when the response code is 404 or other',
//     //     () async {
//     //       // arrange
//     //       setUpMockHttpClientFailure404();
//     //       // act
//     //       final call = dataSource.getConcreteNumberTrivia;
//     //       // assert
//     //       expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
//     //     },
//     //   );
//   });
//   //
//   // group('getRandomNumberTrivia', () {
//   //   final tNumberTriviaModel =
//   //       NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
//   //
//   //   test(
//   //     '''should perform a GET request on a URL with number
//   //      being the endpoint and with application/json header''',
//   //     () async {
//   //       // arrange
//   //       setUpMockHttpClientSuccess200();
//   //       // act
//   //       dataSource.getRandomNumberTrivia();
//   //       // assert
//   //       verify(mockHttpClient.get(
//   //         'http://numbersapi.com/random',
//   //         headers: {
//   //           'Content-Type': 'application/json',
//   //         },
//   //       ));
//   //     },
//   //   );
//   //
//   //   test(
//   //     'should return NumberTrivia when the response code is 200 (success)',
//   //     () async {
//   //       // arrange
//   //       setUpMockHttpClientSuccess200();
//   //       // act
//   //       final result = await dataSource.getRandomNumberTrivia();
//   //       // assert
//   //       expect(result, equals(tNumberTriviaModel));
//   //     },
//   //   );
//   //
//   //   test(
//   //     'should throw a ServerException when the response code is 404 or other',
//   //     () async {
//   //       // arrange
//   //       setUpMockHttpClientFailure404();
//   //       // act
//   //       final call = dataSource.getRandomNumberTrivia;
//   //       // assert
//   //       expect(() => call(), throwsA(TypeMatcher<ServerException>()));
//   //     },
//   //   );
//   // });
// }
