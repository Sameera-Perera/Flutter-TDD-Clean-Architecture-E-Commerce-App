import 'dart:convert';

import '../../../domain/entities/user/delivery_info.dart';

DeliveryInfoModel deliveryInfoModelFromJson(String str) =>
    DeliveryInfoModel.fromJson(json.decode(str)['data']);

List<DeliveryInfoModel> deliveryInfoModelListFromRemoteJson(String str) =>
    List<DeliveryInfoModel>.from(
        json.decode(str)['data'].map((x) => DeliveryInfoModel.fromJson(x)));

String deliveryInfoModelToJson(DeliveryInfoModel data) =>
    json.encode(data.toJson());

class DeliveryInfoModel extends DeliveryInfo {
  const DeliveryInfoModel({
    required String id,
    required String firstName,
    required String lastName,
    required String addressLineOne,
    required String addressLineTwo,
    required String city,
    required String zipCode,
    required String contactNumber,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          addressLineOne: addressLineOne,
          addressLineTwo: addressLineTwo,
          city: city,
          zipCode: zipCode,
          contactNumber: contactNumber,
        );

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
        "firstName": firstName,
        "lastName": lastName,
        "addressLineOne": addressLineOne,
        "addressLineTwo": addressLineTwo,
        "city": city,
        "zipCode": zipCode,
        "contactNumber": contactNumber,
        "_id": id,
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
