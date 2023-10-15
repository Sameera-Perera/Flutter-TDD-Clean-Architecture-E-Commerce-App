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
  id: "1",
  name: "name",
  description: "description",
  priceTags: [PriceTagModel(id: "1", name: "name", price: 100)],
  categories: const [CategoryModel(id: "1", name: "name", image: "image")],
  images: const ["image"],
  createdAt: DateTime(2000),
  updatedAt: DateTime(2000),
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
final tPriceTagModel = PriceTagModel(id: "1", name: "name", price: 100);

//cart
final tCartItemModel = CartItemModel(
  id: "1",
  product: tProductModel,
  priceTag: tPriceTagModel,
);

//category
const tCategoryModel = CategoryModel(
  id: "1",
  name: "name",
  image: "image",
);

// delivery info
const tDeliveryInfoModel = DeliveryInfoModel(
  id: '1',
  firstName: 'firstName',
  lastName: 'lastName',
  addressLineOne: 'addressLineOne',
  addressLineTwo: 'addressLineTwo',
  city: 'city',
  zipCode: 'zipCode',
  contactNumber: 'contactNumber',
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
  id: '1',
  product: tProductModel,
  priceTag: tPriceTagModel,
  price: 100,
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
const tSignUpParams = SignUpParams(firstName: 'firstName', lastName: 'lastName', email: 'email', password: 'password');
