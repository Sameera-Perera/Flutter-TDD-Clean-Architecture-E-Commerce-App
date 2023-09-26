import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/order/order_fetch/order_fetch_cubit.dart';
import '../../../../widgets/order_info_card.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: BlocBuilder<OrderFetchCubit, OrderFetchState>(
        builder: (context, state) {
          if (state is OrderFetchSuccess) {
            return ListView.builder(
              itemCount: state.orders.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) => OrderInfoCard(
                orderDetails: state.orders[index],
              ),
            );
          }
          return Container(
            child: Text("Test"),
          );
        },
      ),
    );
  }
}
