import 'package:eshop/data/models/product_model.dart';

const tProductModel = ProductModel(id: 1, title: "Text", image: "Text", price: 1.00);
const tProductModelList = [
  ProductModel(id: 1, title: "Text", image: "Text", price: 1.00),
  ProductModel(id: 2, title: "Text", image: "Text", price: 2.00)
];
final tProductModelListFuture = Future<List<ProductModel>>.value([
  const ProductModel(id: 1, title: "Text", image: "Text", price: 1.00),
  const ProductModel(id: 2, title: "Text", image: "Text", price: 2.00)
]);