import 'package:equatable/equatable.dart';
import 'package:eshop/domain/entities/category/category.dart';

class CategoryResponse extends Equatable {
  final List<Category> categories;

  const CategoryResponse({required this.categories});

  @override
  List<Object?> get props => [categories];
}
