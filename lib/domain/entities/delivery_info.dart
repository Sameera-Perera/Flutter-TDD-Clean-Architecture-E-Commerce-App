import 'package:equatable/equatable.dart';

class DeliveryInfo extends Equatable {
  final int id;
  final String receiver;
  final String addressLineOne;
  final String addressLineTwo;

  const DeliveryInfo({
    required this.id,
    required this.receiver,
    required this.addressLineOne,
    required this.addressLineTwo,
  });

  @override
  List<Object> get props => [
    id,
    addressLineOne,
    addressLineTwo,
  ];
}