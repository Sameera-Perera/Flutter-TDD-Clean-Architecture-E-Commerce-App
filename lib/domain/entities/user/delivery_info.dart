import 'package:equatable/equatable.dart';

class DeliveryInfo extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String addressLineOne;
  final String addressLineTwo;
  final String city;
  final String zipCode;
  final String contactNumber;

  const DeliveryInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.addressLineOne,
    required this.addressLineTwo,
    required this.city,
    required this.zipCode,
    required this.contactNumber,
  });

  @override
  List<Object> get props => [id];
}
