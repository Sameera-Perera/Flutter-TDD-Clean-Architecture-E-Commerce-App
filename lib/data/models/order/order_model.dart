import '../../../domain/entities/order/order.dart';
import '../product/product_model.dart';
import '../user/delivery_info_model.dart';

class OrderModel extends Order {
  const OrderModel({
    required String id,
    required List<ProductModel> products,
    required DeliveryInfoModel deliveryInfo,
  }) : super(
          id: id,
          products: products,
          address: deliveryInfo,
        );
}
