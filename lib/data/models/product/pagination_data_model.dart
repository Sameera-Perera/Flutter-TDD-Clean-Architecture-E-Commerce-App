import '../../../domain/entities/product/pagination_meta_data.dart';

class PaginationMetaDataModel extends PaginationMetaData {
  PaginationMetaDataModel({
    required int page,
    required int pageSize,
    required int total,
  }): super(
    limit: page,
    pageSize: pageSize,
    total: total,
  );

  factory PaginationMetaDataModel.fromJson(Map<String, dynamic> json) => PaginationMetaDataModel(
    page: json["page"],
    pageSize: json["pageSize"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": limit,
    "pageSize": pageSize,
    "total": total,
  };
}