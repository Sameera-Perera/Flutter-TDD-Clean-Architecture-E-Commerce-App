import 'package:eshop/domain/entities/category/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';

void main() {
  test(
    'CategoryModel should be a subclass of Category entity',
        () async {
      // assert
      expect(tCategoryModel, isA<Category>());
    },
  );
}
