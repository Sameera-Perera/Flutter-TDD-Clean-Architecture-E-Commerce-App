import 'package:eshop/core/error/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/images.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../widgets/cart_card.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).padding.top + 10),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartError && state.cart.isNotEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.failure is NetworkFailure)
                            Image.asset(kNoConnection),
                          if (state.failure is ServerFailure)
                            Image.asset(kInternalServerError),
                          const Text("Cart is Empty!"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          )
                        ],
                      );
                    }
                    if(state.cart.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(kEmptyCart),
                          const Text("Cart is Empty!"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          )
                        ],
                      );
                    }
                    return ListView.builder(
                      itemCount: (state is CartLoading && state.cart.isEmpty)
                          ? 10
                          : state.cart.length,
                      padding: const EdgeInsets.only(top: 14),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (state is CartLoading && state.cart.isEmpty) {
                          return const CartCard();
                        } else {
                          return CartCard(
                            cartItem: state.cart[index],
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
      ),
    );
  }
}
