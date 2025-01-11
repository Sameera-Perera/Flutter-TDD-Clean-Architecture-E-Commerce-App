import 'dart:convert';

import '../../../domain/entities/user/delivery_info.dart';

DeliveryInfoModel deliveryInfoModelFromRemoteJson(String str) =>
    DeliveryInfoModel.fromJson(json.decode(str));

DeliveryInfoModel deliveryInfoModelFromLocalJson(String str) =>
    DeliveryInfoModel.fromJson(json.decode(str));

List<DeliveryInfoModel> deliveryInfoModelListFromRemoteJson(String str) =>
    List<DeliveryInfoModel>.from(
        json.decode(str).map((x) => DeliveryInfoModel.fromJson(x)));

List<DeliveryInfoModel> deliveryInfoModelListFromLocalJson(String str) =>
    List<DeliveryInfoModel>.from(
        json.decode(str).map((x) => DeliveryInfoModel.fromJson(x)));

String deliveryInfoModelToJson(DeliveryInfoModel data) =>
    json.encode(data.toJson());

String deliveryInfoModelListToJson(List<DeliveryInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryInfoModel extends DeliveryInfo {
  const DeliveryInfoModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.addressLineOne,
    required super.addressLineTwo,
    required super.city,
    required super.zipCode,
    required super.contactNumber,
  });

  factory DeliveryInfoModel.fromJson(Map<String, dynamic> json) =>
      DeliveryInfoModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        addressLineOne: json["addressLineOne"],
        addressLineTwo: json["addressLineTwo"],
        city: json["city"],
        zipCode: json["zipCode"],
        contactNumber: json["contactNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "addressLineOne": addressLineOne,
        "addressLineTwo": addressLineTwo,
        "city": city,
        "zipCode": zipCode,
        "contactNumber": contactNumber,
      };

  factory DeliveryInfoModel.fromEntity(DeliveryInfo entity) =>
      DeliveryInfoModel(
        id: entity.id,
        firstName: entity.firstName,
        lastName: entity.lastName,
        addressLineOne: entity.addressLineOne,
        addressLineTwo: entity.addressLineTwo,
        city: entity.city,
        zipCode: entity.zipCode,
        contactNumber: entity.contactNumber,
      );
}
