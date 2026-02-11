part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategories extends CategoryEvent {
  const GetCategories();

  @override
  List<Object> get props => [];
}

class FilterCategories extends CategoryEvent {
  final String keyword;
  const FilterCategories(this.keyword);

  @override
  List<Object> get props => [];
}
