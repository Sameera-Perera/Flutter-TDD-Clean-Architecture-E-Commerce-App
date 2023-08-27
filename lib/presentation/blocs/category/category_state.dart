part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  final List<Category> categories;
  const CategoryState({required this.categories});
}

class CategoryInitial extends CategoryState {
  const CategoryInitial({required super.categories});
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  const CategoryLoading({required super.categories});
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  const CategoryLoaded({required super.categories});
  @override
  List<Object> get props => [];
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError({required super.categories, required this.message});
  @override
  List<Object> get props => [];
}
