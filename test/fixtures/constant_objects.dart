import 'package:eshop/data/models/cart/cart_item_model.dart';
import 'package:eshop/data/models/category/category_model.dart';
import 'package:eshop/data/models/order/order_details_model.dart';
import 'package:eshop/data/models/order/order_item_model.dart';
import 'package:eshop/data/models/product/pagination_data_model.dart';
import 'package:eshop/data/models/product/price_tag_model.dart';
import 'package:eshop/data/models/product/product_model.dart';
import 'package:eshop/data/models/product/product_response_model.dart';
import 'package:eshop/data/models/user/authentication_response_model.dart';
import 'package:eshop/data/models/user/delivery_info_model.dart';
import 'package:eshop/data/models/user/user_model.dart';
import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
import 'package:eshop/domain/usecases/user/sign_in_usecase.dart';
import 'package:eshop/domain/usecases/user/sign_up_usecase.dart';

//products
final tProductModel = ProductModel(
    id: "64eb722a41cb9b05eb4420b7",
    name: "Asus Gaming Mouse",
    description: "Text description",
    priceTags: [tPriceTagModel],
    categories: const [tCategoryModel],
    images: const [
      "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/vxyyemcdwcuoooyejehj.jpg",
      "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/vqiw6cswpnzhgryd3s1l.jpg",
      "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/tkanjwktt2t0qvybk5xf.jpg",
      "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/yjxkgevogpaim02wonks.jpg",
      "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/m2bb9pzzobynrpyo9ike.jpg",
      "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/xhojjofgfyfpbjwo2vox.jpg"
    ],
    createdAt: DateTime.parse("2023-08-27T15:56:26.504Z"),
    updatedAt: DateTime.parse("2023-08-27T16:19:16.683Z"),
);

final tProductModelList = [tProductModel, tProductModel];
final tProductModelListFuture =
    Future<List<ProductModel>>.value([tProductModel, tProductModel]);

const tFilterProductParams = FilterProductParams();

//product response
final tProductResponseModel = ProductResponseModel(
  meta: PaginationMetaDataModel(
    page: 0,
    pageSize: 0,
    total: 0,
  ),
  data: [
    tProductModel,
    tProductModel,
  ],
);

//price tag
final tPriceTagModel = PriceTagModel(
  id: "64eb728341cb9b05eb4420ba",
  name: "White",
  price: 50.99,
);

//cart
final tCartItemModel = CartItemModel(
  id: "1",
  product: tProductModel,
  priceTag: tPriceTagModel,
);

//category
const tCategoryModel = CategoryModel(
  id: "64cecb613357eaec7b1ab31b",
  name: "Headphone",
  image: "https://res.cloudinary.com/dhyttttax/image/upload/v1693148015/category/headphone_pdqwo2.jpg",
);

// delivery info
const tDeliveryInfoModel = DeliveryInfoModel(
  id: '1',
  firstName: 'Jon',
  lastName: 'Perera',
  addressLineOne: '23/1 Main Road',
  addressLineTwo: 'Navinna',
  city: 'Mahragama',
  zipCode: '10800',
  contactNumber: '0779125803',
);

// order details
final tOrderDetailsModel = OrderDetailsModel(
  id: '1',
  orderItems: [tOrderItemModel],
  deliveryInfo: tDeliveryInfoModel,
  discount: 0,
);

// order item
final tOrderItemModel = OrderItemModel(
  id: '651301997eae44a63472d728',
  product: tProductModel,
  priceTag: tPriceTagModel,
  price: 50.99,
  quantity: 1,
);

//user
const tUserModel = UserModel(
  id: '1',
  firstName: 'Text',
  lastName: 'Text',
  email: 'text@gmail.com',
);

//
const tAuthenticationResponseModel =
    AuthenticationResponseModel(token: 'token', user: tUserModel);
//params
const tSignInParams = SignInParams(username: 'username', password: 'password');
const tSignUpParams = SignUpParams(
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    password: 'password');
