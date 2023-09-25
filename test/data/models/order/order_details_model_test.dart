import 'package:eshop/domain/entities/order/order_details.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';

void main() {
  test(
    'OrderDetailsModel should be a subclass of OrderDetails entity',
        () async {
      // assert
      expect(tOrderDetailsModel, isA<OrderDetails>());
    },
  );
}
