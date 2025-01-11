import '../../../domain/entities/product/pagination_meta_data.dart';

class PaginationMetaDataModel extends PaginationMetaData {
  PaginationMetaDataModel({
    required int page,
    required super.pageSize,
    required super.total,
  }): super(
    limit: page,
  );

  factory PaginationMetaDataModel.fromJson(Map<String, dynamic> json) => PaginationMetaDataModel(
    page: json["page"]??0,
    pageSize: json["pageSize"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": limit,
    "pageSize": pageSize,
    "total": total,
  };
}