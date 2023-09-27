import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/router/app_router.dart';
import '../../../../domain/entities/cart/cart_item.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../widgets/cart_item_card.dart';
import '../../../widgets/input_form_button.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItem> selectedCartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
              children: [
                // SizedBox(
                //   height: (MediaQuery.of(context).padding.top + 10),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartError && state.cart.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state.failure is NetworkFailure)
                                Image.asset(kNoConnection),
                              if (state.failure is ServerFailure)
                                Image.asset(kInternalServerError),
                              const Text("Cart is Empty!"),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                            ],
                          );
                        }
                        if (state.cart.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(kEmptyCart),
                              const Text("Cart is Empty!"),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                            ],
                          );
                        }
                        return ListView.builder(
                          itemCount:
                              (state is CartLoading && state.cart.isEmpty)
                                  ? 10
                                  : (state.cart.length +
                                      ((state is CartLoading) ? 10 : 0)),
                          padding: EdgeInsets.only(
                              top: (MediaQuery.of(context).padding.top + 20),
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 200),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (state is CartLoading && state.cart.isEmpty) {
                              return const CartItemCard();
                            } else {
                              if(state.cart.length<index){
                                return const CartItemCard();
                              }
                              return CartItemCard(
                                cartItem: state.cart[index],
                                isSelected: selectedCartItems.any(
                                    (element) => element == state.cart[index]),
                                onLongClick: () {
                                  setState(() {
                                    if (selectedCartItems.any((element) =>
                                        element == state.cart[index])) {
                                      selectedCartItems
                                          .remove(state.cart[index]);
                                    } else {
                                      selectedCartItems.add(state.cart[index]);
                                    }
                                  });
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state.cart.isEmpty) {
                return const SizedBox();
              }
              return Positioned(
                bottom: (MediaQuery.of(context).padding.bottom + 90),
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 4, left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total (${state.cart.length} items)',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              '\$${state.cart.fold(0.0, (previousValue, element) => (element.priceTag.price + previousValue))}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: InputFormButton(
                          color: Colors.black87,
                          cornerRadius: 36,
                          padding: EdgeInsets.zero,
                          onClick: () {
                            Navigator.of(context).pushNamed(
                                AppRouter.orderCheckout,
                                arguments: state.cart);
                          },
                          titleText: 'Checkout',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
