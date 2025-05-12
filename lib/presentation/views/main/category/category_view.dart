import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/category/category_bloc.dart';
import '../../../widgets/category_card.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final TextEditingController _textEditingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).padding.top + 8),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextField(
                controller: _textEditingController,
                autofocus: false,
                style: TextStyle(color: colorScheme.onBackground),
                onSubmitted: (val) {
                  context.read<CategoryBloc>().add(FilterCategories(val));
                },
                onChanged: (val) => setState(() {
                  context.read<CategoryBloc>().add(FilterCategories(val));
                }),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20, bottom: 22, top: 22),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(Icons.search, color: colorScheme.onBackground.withOpacity(0.7)),
                  ),
                  suffixIcon: _textEditingController.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _textEditingController.clear();
                                context.read<CategoryBloc>().add(const FilterCategories(''));
                              });
                            },
                            icon: Icon(Icons.clear, color: colorScheme.onBackground.withOpacity(0.7)),
                          ),
                        )
                      : null,
                  border: const OutlineInputBorder(),
                  hintText: "Search Category",
                  hintStyle: TextStyle(color: colorScheme.onBackground.withOpacity(0.5)),
                  fillColor: colorScheme.surface,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: (state is CategoryLoading) ? 10 : state.categories.length,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: 14,
                      bottom: (80 + MediaQuery.of(context).padding.bottom),
                    ),
                    itemBuilder: (context, index) => (state is CategoryLoading)
                        ? const CategoryCard()
                        : CategoryCard(
                            category: state.categories[index],
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
