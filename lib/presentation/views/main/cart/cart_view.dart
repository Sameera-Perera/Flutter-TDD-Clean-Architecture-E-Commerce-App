import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                        } else if (state is CartError) {
                          return const Center(
                            child: Text("Error"),
                          );
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
