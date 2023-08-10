import 'package:eshop/domain/entities/product/product.dart';
import 'package:eshop/presentation/blocs/product/product_bloc.dart';
import 'package:eshop/presentation/widgets/Product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
            const Row(
              children: [
                Text(
                  "Sameera Perera",
                  style: TextStyle(fontSize: 26),
                ),
                Spacer(),
                Icon(
                  Icons.notifications_none,
                  color: Colors.black45,
                ),
                SizedBox(
                  width: 8,
                ),
                CircleAvatar(
                  radius: 24.0,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 20, bottom: 22, top: 22),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.search),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: "Search Product",
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(32)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 3.0),
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                    return GridView.builder(
                      itemCount:
                          (state is ProductLoaded) ? state.products.length : 10,
                      padding:  EdgeInsets.only(top: 14, bottom: (80+ MediaQuery.of(context).padding.bottom)),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.55,
                        crossAxisSpacing: 6,
                      ),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (state is ProductLoaded) {
                          return ProductCard(
                            product: state.products[index],
                          );
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: const ProductCard(),
                        );
                      },
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
